<?php
// drupal_get_messages('status',true); //remove status messages that we do not to appear on the form
$name = 'SCENARIO_TYPE';
$myvoc = taxonomy_vocabulary_machine_name_load($name);
$scenarios = taxonomy_get_tree($myvoc->vid);
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
