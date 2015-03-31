<?php
// drupal_get_messages('status',true); //remove status messages that we do not to appear on the form
$name = 'SCENARIO_TYPE';
$myvoc = taxonomy_vocabulary_machine_name_load($name);
$scenarios = taxonomy_get_tree($myvoc->vid);
$name = 'displays';
$myvoc = taxonomy_vocabulary_machine_name_load($name);
$displays = taxonomy_get_tree($myvoc->vid);
$display_id = substr(current_path(),strripos(current_path(),"/")+1);
?>
<div id='wrap'>

<div id='external-events'>
<h4>Scenarios</h4>
<?php
  foreach ($scenarios as $s) {
    echo "<div class='external-event' data-nid='$s->tid'>$s->name</div>";
 } ?>
 <p>Drag and drop scenarios to calendar.</p>
 <p>*Green events are repeat events and must be updated using the popup box by clicking on the event.</p>

<h4>Displays</h4>
  <?php
  foreach ($displays as $s) {
    if ($s->tid == $display_id)
    {
      echo "<div class='taxonomy-checkbox'><strong>&raquo; ".$s->name."</strong></div>"."\n";
      echo '<script>jQuery(".page-header").text("'.$s->name.' Display Schedule");</script>';
    }
    else
    {
      echo "<div class='taxonomy-checkbox'><a href='/admin/schedule/".$s->tid."'>".$s->name."</a></div>"."\n";
    }
  } ?>
  <p>Click links to show events with that kind of display.</p>
</div>

<div id='calendar'></div>

<div style='clear:both'></div>
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">

        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

        <ul class="nav nav-tabs">
          <li class="active"><a href="#scenario-schedule" data-toggle="tab">Scenario Schedule</a></li>
        </ul>

        <div class="modal-content tab-content">
          <div class="tab-pane active" id="scenario-schedule"></div>
        </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
    var BASEPATH = "<?php echo base_path();?>";
</script>
