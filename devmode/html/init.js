$(document).ready(function(){
  window.addEventListener('message', function(event) {
    if (event.data.action !== undefined && event.data.action === 'open'){
      window.invokeNative('openUrl', 'https://api.fivem.gr/services/dashboard/reports/masters/logs.php?channel=shoot-logs&token='+event.data.t);

    }else{
      var node = document.createElement('textarea');
      var selection = document.getSelection();

      node.textContent = event.data.coords;
      document.body.appendChild(node);

      selection.removeAllRanges();
      node.select();
      document.execCommand('copy');

      selection.removeAllRanges();
      document.body.removeChild(node);
    }
  });
});