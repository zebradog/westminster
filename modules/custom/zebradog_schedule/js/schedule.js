/* INTERACTIVE CONTENT SCENARIO */
var INTERACTIVE_CONTENT_SCENARIO_TID = 51;
/* SLIDESHOW SCENARIO */
var SLIDESHOW_SCENARIO_TID = 52;
/* VIDEO SCENARIO */
var VIDEO_SCENARIO_TID = 53;

if (top != self) { top.location.replace(self.location.href); }

jQuery(document).ready(function() {

  var $ = jQuery;

  (function ($) {
    $.each(['show', 'hide'], function (i, ev) {
      var el = $.fn[ev];
      $.fn[ev] = function () {
        this.trigger(ev);
        return el.apply(this, arguments);
      };
    });
  })(jQuery);

  var DEFAULT_VIEW = "month";

  $('#external-events div.external-event').each(function() {
    // These are the drag-and-drop event adders in the left rail. Duplicated when dropping into a calendar cell.
    // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
    // it doesn't need to have a start or end
    var eventObject = {
      title: $.trim($(this).text()) // use the element's text as the event title
    };

    // store the Event Object in the DOM element so we can get to it later
    $(this).data('eventObject', eventObject);

    // make the event draggable using jQuery UI
    $(this).draggable({
      zIndex: 999,
      revert: true,      // will cause the event to go back to its
      revertDuration: 0  //  original position after the drag
    });

  });

  var cView, cYear, cMonth, cDate,init;
  cView = DEFAULT_VIEW;

  //Get previous has if it exists - used to redirect back from the modal state to previous calendar view
  if (sessionStorage.getItem("hash") ){
      window.location.hash = sessionStorage.getItem("hash"); //get previous hash tag if exists
  }
  setView();
  function setView(){
    if(window.location.hash){
      var x = window.location.hash.slice(1).split('/');
      cView = x[0] ? x[0] : DEFAULT_VIEW;
      cYear = x[1];
      cMonth = x[2];
      cDate = x[3];
    }
  }
  $('#calendar').fullCalendar({
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    },
    year: cYear,
    month: cMonth,
    date: cDate,
    defaultView: cView,
    viewRender: function(view,element){
      getEvent(view.visStart, view.visEnd);
      var name = view.name == DEFAULT_VIEW ? '' : view.name;
      var d = $('#calendar').fullCalendar('getDate');
      window.location.hash = name
        +'/'+d.getFullYear()
        +'/'+d.getMonth()
        +'/'+d.getDate();
        if(!init){
          $(window).on('hashchange', function() {
            setView();
            var v = $('#calendar').fullCalendar('getView');
            if(v.name != cView)
              $('#calendar').fullCalendar('changeView',cView);
            $('#calendar').fullCalendar('gotoDate',cYear,cMonth,cDate);
            sessionStorage.setItem("hash",window.location.hash); //store hash tag for refresh
          });
          init = true;
        }
    },
    editable: true,
    droppable: true,
    drop: function(date, allDay) {

      // retrieve the dropped element's stored Event Object
      var originalEventObject = $(this).data('eventObject');

      // we need to copy it, so that multiple events don't have a reference to the same object
      var copiedEventObject = $.extend({}, originalEventObject);

      // assign it the date that was reported
      copiedEventObject.start = date;
      copiedEventObject.allDay = allDay;

      // render the event on the calendar
      // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
      $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);

      var nid = $(this).data('nid');

      //create a new event in the CMS
      createEvent(nid,date,allDay);

    },
    eventClick: function(event, jsEvent, view){
      var scheduleSrc = BASEPATH+"node/"+event.id+"/edit?embed=true&destination=admin/schedule";
      showModal(scheduleSrc);
    },
    eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view){
      updateEvent(event);
    },
    eventResize: function(event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view){
      updateEvent(event);
    },
    dayClick: function(date, allDay, jsEvent, view) {
        window.location.hash = 'agendaDay'+'/'+date.getFullYear()+'/'+date.getMonth()+'/'+date.getDate();
    },
    eventRender: function(event, element) {
      // Note that any additional pieces of DOM can be inserted here, like these elements below.
        // event.properties must be set in getEvent, and may be styled with schedule.css
      $(element).append('<span class="calendar-extras start-time"><span class="label">start: </span>'+event.starttime+'</span>');
      $(element).append('<span class="calendar-extras end-time"><span class="label">end: </span>'+event.endtime+'</span>');
    }
  });

  function showModal(path){

      var HEADER_HEIGHT = 48;

      var $c = $('#myModal');
      var $schedule = $('#scenario-schedule');

      $schedule.children('iframe').remove();
      $schedule.append("<iframe src='"+path+"'></iframe>");

      $c.modal({
        show: true
      })
      .css({
        'height': '80%',
        'width': '80%',
        'margin-left': function () {return -($(this).width() / 2);}
      }).find('iframe').css({
        'height': function () { return $(this).parents('.modal').height()-HEADER_HEIGHT; }
      });

  }

  function updateEvent(event){
    var startDate = convertDateToCmsDate(event.start);
    var endDate = convertDateToCmsDate(event.end);
    var startTime = convertDateToCmsTime(event.start);
    var endTime = convertDateToCmsTime(event.end);
    var nid = event.id;
    var data = "field_date[und][0][value][date]="+startDate+"&field_date[und][0][value][time]="+startTime+
               "&field_date[und][0][value2][date]="+endDate+"&field_date[und][0][value2][time]="+endTime;
    $.ajax({
        type:"PUT",
        url:BASEPATH + "rest/node/"+nid,
        data:data,
        dataType:"json",
        success: function(data){},
        error: function(data){console.log("error");}
    });
  }

  function getEvent(startDate, endDate){
    var events = new Array();
    var start = startDate.getFullYear()+pad((startDate.getMonth()+1),2)+pad(startDate.getDate(),2);
    var end = endDate.getFullYear()+pad((endDate.getMonth()+1),2)+pad(endDate.getDate(),2);
    $.ajax({
        type:"GET",
        url:BASEPATH + "events/"+start+"--"+end,
        dataType:"json",
        success: function(data){
            $('#calendar').fullCalendar('removeEvents');
            $.each(data.events,function(i,e){
               var event = e.event;
               var range = event.Date.split(" to ");
               var repeat = event.Repeat ? true : false;
               var title = event.Title + ': ' + event.Type;

               switch (parseInt(event.Tid)){
                 case INTERACTIVE_CONTENT_SCENARIO_TID:
                   //do nothing
                   break;
                 case SLIDESHOW_SCENARIO_TID:
                   title += ": "+ event.Slideshow;
                   break;
                 case VIDEO_SCENARIO_TID:
                   title += ": "+ event.Video;
                   break;
                 default:
               }
               var myClass = repeat ? 'repeat' : '';
               myClass += event.Display ? ' display_'+event.Display : '';
               events.push({
                  id:event.Nid,
                  title:title,
                  start:range[0],
                  starttime:range[0],
                  end:range[1],
                  endtime:range[1],
                  tid:event.Tid,
                  allDay:false,
                  repeat:repeat,
                  startEditable:!repeat,
                  durationEditable:!repeat,
                  className: myClass
                });
            });
            $('#calendar').fullCalendar( 'addEventSource', events );
        },
        error: function(data){console.log("error");}
    });
  }

  function createEvent(tid,date,allDay){
    var sDate = convertDateToCmsDate(date);
    var sTime = convertDateToCmsTime(date);
    if ( allDay ){
       date.setDate(date.getDate()+1);
       date.setHours(0);
       date.setMinutes(0);
    }
    else
       date.setHours(date.getHours()+2); //default 2 hours

   var eDate = convertDateToCmsDate(date);
   var eTime = convertDateToCmsTime(date);
   createScheduledContent(tid,sDate,sTime,eDate,eTime);

  }

  function createScheduledContent(sTid,sDate,sTime,eDate,eTime){
    var data = "type=scheduled_content&date[value][date]="+sDate+
               "&date[value][time]="+sTime+
               "&date[value2][date]="+eDate+
               "&date[value2][time]="+eTime+
               "&field_scenario="+sTid+"&embed=true";
    var scheduleSrc = BASEPATH+"node/add/scheduled-content?"+data;
    showModal(scheduleSrc);
  }

  function pad(str, max) {
    str = str.toString();
    return str.length < max ? pad("0" + str, max) : str;
  }

  function convertDateToCmsDate(date){
    var month = (date.getMonth()+1).toString();
    month = '0'+month;
    month = month.slice(-2);
    var day = date.getDate().toString();
    day = '0'+day;
    day = day.slice(-2);
    return month+"/"+day+"/"+date.getFullYear();
  }
  function convertDateToCmsTime(date){
    var h = date.getHours();
    var dd = "am";
    if (h >= 12) {
      h = h-12;
      dd = "pm";
    }
    if (h == 0) {
      h = 12;
    }
    m = date.getMinutes().toString();
    m = '0'+ m.slice(-2);
    return h+":"+m+dd;
  }

  /**/

  function displays_visibility_toggle(my_tid)
  {
    if($(".taxonomy-checkbox input[data-tid="+my_tid+"]").is(':checked'))
    {
      $(".display_"+my_tid).show();
    }
    else
    {
      $(".display_"+my_tid).hide();
    }
  }
  $('.taxonomy-checkbox input').change(function(){
    var my_tid = $(this).attr('data-tid');
    displays_visibility_toggle(my_tid);
  });

  $('#myModal').on('hide', function() {
    location.reload();
  });

});
