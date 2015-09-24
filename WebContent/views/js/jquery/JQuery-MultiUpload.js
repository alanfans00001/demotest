(function($) {

    $.fn.multiupload = function(options) {

        var multiupload = this;

        options = $.extend({
            fileSelector: ".file-upload",
            deleteSelector: ".delete-file"
        }, options || {});

        var fileNameDataKey = "targetFileName";

        var addOperate = function(target) {
            var warp = $("<div></div>");
            multiupload.append(warp);

            warp.append(target);
            target = $(target);

            var deleteButton = $("<a></a>");
            warp.prev().append(deleteButton);
            deleteButton.text("лчЁЩ");
            deleteButton.attr("href", "javascript:void(0);");
            deleteButton.data(fileNameDataKey, target.attr("name"));
            deleteButton.addClass(options.deleteSelector.substring(1));
        };

        var fileCount = function() {
            return multiupload.find(options.fileSelector).size();
        };

        var emptyFileCount = function() {
            return multiupload.find(options.fileSelector).filter(function() {
                return !$(this).val();
            }).size();
        };

        var templete = multiupload.find(options.fileSelector + ":first");
        // addOperate(templete);
        var div = $("<div></div>");
        div.append(templete);
        multiupload.append(div);
        //alert(multiupload.html());

        var baseName = templete.attr("name");

        var count = 1;

        this.find(options.fileSelector).change(function() {
            var self = $(this);

            if (self.val() && emptyFileCount() === 0) {
                var newFile = self.clone(true);

                self.parent().append(newFile);
                newFile.val(null);
                newFile.attr("name", baseName + ++count);

                addOperate(newFile);
            }

        });

        this.find(options.deleteSelector).live("click", function() {
            var self = $(this);
            self.parent().remove();
            //            var fileName = self.data(fileNameDataKey);
            //            var file = multiupload.find("input[name=" + fileName + "]");

            //            if (fileCount() === 1) {
            //                file.val(null);
            //            } else {
            //                file.parent().remove();
            //            }

        });

    };



})(jQuery);