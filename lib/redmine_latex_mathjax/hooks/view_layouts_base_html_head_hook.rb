module RedmineLatexMathjax
  module Hooks
    class ViewLayoutsBaseHtmlHeadHook < Redmine::Hook::ViewListener
      def view_layouts_base_html_head(context={})
          return "<script type=\"text/x-mathjax-config\">
          MathJax.Hub.Config({
    extensions: ['tex2jax.js'],
    jax: ['input/TeX', 'output/HTML-CSS'],
    tex2jax: {
      inlineMath: [ ['$','$'] ],
      displayMath: [ ['$$','$$'] ],
      processEscapes: true,
      ignoreClass: 'text-diff'
    },
    'HTML-CSS': { availableFonts: ['TeX'] }
  });
          MathJax.Hub.Typeset();
          </script>" +
            javascript_include_tag('MathJax/MathJax.js?config=TeX-AMS-MML_HTMLorMML') +
            javascript_include_tag('jquery-2.1.4.min.js')+
            '<script>
  jQuery.fn.contentChange = function(callback){
    var elms = jQuery(this);
    elms.each(
      function(i){
        var elm = jQuery(this);
        elm.data("lastContents", elm.html());
        window.watchContentChange = window.watchContentChange ? window.watchContentChange : [];
        window.watchContentChange.push({"element": elm, "callback": callback});
      }
    )
    return elms;
  }
  setInterval(function(){
    if(window.watchContentChange){
      for( i in window.watchContentChange){
        try {
        if(window.watchContentChange[i].element.data("lastContents") != window.watchContentChange[i].element.html()){
          window.watchContentChange[i].callback.apply(window.watchContentChange[i].element);
          window.watchContentChange[i].element.data("lastContents", window.watchContentChange[i].element.html())
        }
        }
        catch(err){}
      }
    }
  },500);
</script>' + 
            "<script>
            $.noConflict();
            jQuery(document).ready(function($) {
                $('#preview').contentChange(function() { try { MathJax.Hub.Typeset(); } catch(err) {}} );
            });
            </script>" 
      end
    end
  end
end
