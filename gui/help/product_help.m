function [] = product_help(src, eventdata)
    web(fullfile(fileparts(which('installnfsim')),'htmldoc','nfsim_intro.html'),'-helpbrowser');
end