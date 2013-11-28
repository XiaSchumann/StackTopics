#!/usr/bin/perl -w
use DBI;
use strict;
use warnings;

my  $dsn = "DBI:mysql:database=so;host=localhost;port=3306";

my $dbh = DBI->connect($dsn,'root','') or die "Connection Error: $DBI::errstr\n";




my @array = ("c#-4.0","c#-5.0", "c#-to-f#","c#-3.0","c#-2.0","c#-to-vb.net","c#-language","visual-c#-express-2010","vb.net-to-c#","c#","c-sharp","c#.net");
addAssociations("c#-learning", \@array);

@array = ("c++11", "c++-cli", "vc", "c++0x", "cpp", "vc9", "vc6", "c++builder","objective-c-blocks","c++","visual-c++","dynamic-c","effective-c++","modern-c++","python-c-api","python-c-extension","c-strings","visual-c++-2010","visual-c++-2008","visual-c++-2005","objective-c-2","objective-c++","visual-c++-2008-express","c++-faq","c-like","c++-cli","turbo-c","c++-standard-library","accelerated-c++","managed-c++","c++0x","c-functions","dev-c++","kr-c","c-with-classes","lua-c++-connection","c");
addAssociations("c++-learning", \@array);

@array = ("java-web-start","javacompiler","java-interop","java-api","java-ee-6","java-ee-5","java.util.concurrent","javac","javaagents","javax.script","javax.swing","java-frameworks","javahelp","javabeans","java-libraries","java","javamail","java-web-framework","java-util-scanner","javadoc","javacard","java1.6","java1.4","javasound","java-me","java-io","java-ee","wsdl2java","javafx","javadb","javacc","java-3d","java-2d","java-7","java-6","java-5","java-server","java-applet");
addAssociations("java-learning", \@array);

@array = ("python-import","pythoncard","pdb-python","cpython","ironpython-studio","python-interpreter","python","python-modules","python-c-api","python-c-extension","python-datamodel","wxpython","python-module","ipython","python-3.x","biopython","python-2.x","python-2.7","python-2.6","python-2.5","python-interactive","boost-python","pythonic","mysql-python","python-install","parallel-python","ironpython","mod-python");
addAssociations("python-learning", \@array);

@array = ("php-spl","php6","php5","php4","phpexcel","phpdoc","delphi4php","php-extension","php-multithreading","php.ini","php-gettext","phpdocumentor","amfphp","php-pcntl","cakephp-1.3","cakephp-1.2","php-nonfeatures","firephp","php-gtk","php","phpbb","log4php","php-safe-mode","cakephp","php-cli","phpquery","mod-php","php-posix","php-compile","phpmailer","php-frameworks","phpmyadmin","phpunit","php5.3");
addAssociations("php-learning", \@array);

@array = ("no-javascript","javascript-execution","javascript-engine","unobtrusive-javascript","javascript-library","javascript","javascript-framework","javascript-events","javascript-objects","javascript-toolkit","serverside-javascript");
addAssociations("javascript-learning", \@array);


@array = ("oracle","oracle10g","oracle11g","oracle9i","oracle-xe","oracleforms","oracleclient","cx-oracle","oracleinternals","oracle-forms","oracle-sqldeveloper", "system.data.oracleclient","oraclereports","oracle-apps","oracle-coherence","oracle-ucm","oracle-rac","oracle8i","oracle-streams","oraclecommand", "oracleapplications","oracle-text","oracle-spatial","oracleexception","oracleasm","oracle-aq");
addAssociations("oracle", \@array);

@array = ("mysql","mysql-query","mysqldump","mysqli","mysql-management","mysql-error-1064","mysql-connector","mysql-workbench","mysql-triggers","mysqlimport", "mysql-real-escape-string","mysql5","mysql-insert-id","mysql4","mysqlworkbench","mysql-error-1005","mysql-error-1062","php-mysql","libmysql", "mysql-connect","mysql-error","mysql++","mysql-insert","mysql-error-1093","mysqladministrator","mysqld","mysql-table","mysql-error-1054", "mysqlclient","mysql-pconnect","mysql-error-1025","mysql-5.0","mysqldumpslow","mysqlconnection","mysql-python");
addAssociations("mysql", \@array);

@array = ("sql-server","sql-server-2005","sql-server-2008","sql-server-2000","sql-server-ce","sql-server-express","sql-server-management-stu","sql-server-2008-express", "sql-server-2005-express","sql-server-agent","sql-server-2008-r2","sql-management-studio","odbc-sql-server-driver","sql-server-administration", "sql-server-profiler","sql-server-migration-assi","pymssql","mssqlft","sql-server-performance","sql-server-mobile","sql-server-native-client", "sql-server-7","sqlservermanagementstudio","sql-server-data-services"); 
addAssociations("sql-server", \@array);

@array = ("sqlite","sqlite3","system.data.sqlite","pysqlite","sqlite3-ruby","sqlite2","android-sqlite","sqlitejdbc","sqllite","sqlitemanager");
addAssociations("sqlite", \@array);

@array = ("postgresql","plpgsql","npgsql","pygresql","sql-postgres");							
addAssociations("postgresql", \@array);




@array = ("git-core","git-submodules","git-push","git-p4","git-pull","git-mv","git-gc","git-log","git-extensions","tortoisegit","git-diff","git-daemon","gitconfig", "git-rebase","git-post-receive","git-clone","git-update-server-info","gitpython","gitweb","msisgit","git-stash","gitextensions", "git-fetch","git-merge","githooks","p4git","git-revert","github","git-remote","git-gui","git-reset","git-checkout","git-tag", "gitgui","git-svn","gitosis","git-commit","gitignore","git-branching","git-bisect","jgit","git","git-config","git-status","gitorious", "msysgit","gitx","gitk","git-filter-branch","magit","egit","git-cvs","github-api","stacked-git","gitattributes","gitolite","gitnub","hg-git", "git-workflow","git-add");
addAssociations("git", \@array);

@array = ("svnant","rapidsvn","bzr-svn","libsvn","python-svn-swig-api","sharpsvn","hgsvn","pysvn","rocketsvn","tortoisesvn","statsvn","svnversion", "svn-administraton","svnkit","svn-repository","websvn","svnbridge","tsvncache","svndumpfilter","svn-client","mod-dav-svn","svn-copy","svn-externals", "visualsvn-server","svn-update","svn-tools","svn-export","git-svn","smartsvn","svn-merge","svn-config","svnversiontask","tortoise-svn","svn", "svn-trunk","svnadmin","svnlook","svn-server","mercurial-svn","svn-organization","ankhsvn","cvs2svn","svnexternal","tortisesvn","svn-switch", "svnignore","svnserve","visualsvn","xcode-svn","svnmerge","svnsync");
addAssociations("svn", \@array);


@array = ("android-livefolders","android-menu","android-contentprovider","android-service","android-images","android-pullparser","android-layers","android-shared-preference","android-datepicker","effective-android","android-wake-lock","android-parser","android-networking","android-widget","android-adapter","android-c2dm","android-capture","android-maps","android-record","android-video-player","android-database","android-sdk","android-softkeyboard","android-music-player","android-rom","android-ui","android-gallery","android-package-managers","android-tabwidget","android-camera-intent","android-notifications","android-version","android-stylesheeets","android-keypad","android-preferences","android-camera","android-sdcard","android-market","android-phone","android-animation","android-context","android-scripting","android-titlebar","android-contacts","android-ndk","android-imageview","android-manifest","android-syncadapter","android-map","android-website","android-htc-hero","android-intent","android-source","android-projects","android-send-me-logs","android-hardware","android-ndk-r4","android-assets","android-sqlite","android-emulator","android","android-preference","android-style-tabhost","android-photos","android-listview","android-layout","android-twitter","android-process","android-fonts","android-lifecycle","android-audio","android-wifi","android-sdk-2.2","android-sdk-2.1","android-browser","android-sdk-1.6","android-tabhost","android-2.2","android-2.1","android-2.0","android-searchmanager","android-webview","android-graphics","android-1.6","android-location","android-avd","android-install-apk","android-apk","android-custom-view","android-image","android-memory","android-alarms","android-example","android-build","android-performance","android-xml","android-device");
addAssociations("android", \@array);

@array = ("iphone-plist","iphone-sdk-3.2","iphone-sdk-3.1","iphone-sdk-3.0","iphone-provisioning","iphone4","iphone-sdk-4.0.1","facebook-iphone-sdk","iphone-3gs","iphone-sdk-2.2.1","iphone-applications","iphone-privateapi","iphone-simulator","iphone-app","iphone-accessory","box2d-iphone","iphone-network","iphone-vibrate","iphone-developer-program","iphone-video","iphonecoredatarecipes","iphone-sdk-documentation","iphone-web","iphone-wax","iphone-os-4","iphone-os-3","iphone","iphone-os-4.0","iphone-maps","iphone-os","iphone-security","iphone-sdk-3.1.3","iphone-sdk-3.1.2","iphone-sdk","iphone-private-api","iphone-development","iphone-web-app","iphone-compilers","cocos2d-iphone","iphoneos2.0","iphone-sdk-4","iphone-sdk-3","iphone-sdk-2","iphone-sdk-4.0","cocor","cocoa","rococoa","ruby-cocoa","hotcocoa","cocoa-bindings","cocos2d","cocoa-design-patterns","rubycocoa","cocoa-touch","cocotron","cocoahttpserver","cocos2d-iphone","cocoon");
addAssociations("iphone", \@array);

@array = ("blackberry-storm","blackberry-widget","blackberry-os-v5","blackberry-os-6","blackberry-torch","blackberry-jde","blackberry-eclipse-plugin","blackberry-simulator","blackberry-widgets","blackberry-os-v4.5","blackberry");
addAssociations("blackberry", \@array);

@array = ("windows-mobile","windows-mobile-6","windows-mobile-gps","windows-mobile-6.5","windows-mobile-6.1","windows-mobile-2003","windows-mobile-5.0");
addAssociations("windows-phone", \@array);



@array = ("php-spl","php6","php5","php4","phplist","phpthumb","php5-gd","phpexcel","phpdoc","php-on-trax","delphi4php","php-extension","phpmail","php-pdo","phpbms","php-multithreading","php-in-array","php-soapclient","phpbb3","php-oop","php.ini","php-include","phpmyid","php-gd","php-gettext","php-socket","php-mysql","phpspec","phpdocumentor","php-session","phpdocumenter","sphinx-php","phpdoctor","phpdoctrine","amfphp","php-mode","php-operators","php-security","php-pcntl","php-ini","php-ide","cakephp-1.3","cakephp-1.2","php-nonfeatures","firephp","easyphp","phptal","php-gtk","php","phped","phpinfo","phpcs","phpbb","mongodb-php","php-modules","log4php","php52","php-safe-mode","phpflickr","php-dom","cakephp","php-library","php-cli","phpeclipse","mod-php","php-posix","php-java-bridge","php-exec","php-closures","php-errors","maven-for-php","php-compile","phpundercontrol","php-parser","php5-cgi","phpmailer","php-frameworks","php-beautifier","phpmyadmin","php-packages","jqgrid-php","php-form-processing","phpunit","phppgadmin","php-performance","vcl4php","suphp","php5.3");
addAssociations("php-scripting", \@array);

@array = ("python-import","pythoncard","pdb-python","p4python","cpython","python-multithreading","ironpython-studio","python-interpreter","bpython","python-imaging-library","gdata-python-client","python-idle","python-ide","python","python-modules","python-c-api","python-c-extension","python-datamodel","wxpython","python-egg-cache","pythonpath","python-decorators","python-module","python-svn-swig-api","ipython","python-3.x","python-3.1","biopython","python-server-pages","python-socketserver","python-extensions","python-2.x","python-2.7","python-2.6","python-2.5","python-2.4","python-2.1","python-embedding","portable-python","dnspython","python-twitter","vpython","plpython","python-memcached","activepython","python-interactive","boost-python","pythonic","pythonce","mysql-python","gitpython","python-install","python.h","python-path","pythonw","python-openid","python-visual","parallel-python","python-mode","firepython","ironpython","mod-python");
addAssociations("python-scripting", \@array);

@array = ("perl6","perl4","perltk","perlapp","perl-xs","perl","perl-oo","perl-io","mod-perl-registry","perl2exe","pperl","mod-perl","perlvar","perlsyn","log4perl","perl-filesystem","hyperlinks","strawberry-perl","idiomatic-perl","hyperlink","perl-context","cperl-mode","perlbrew","perl-critic","perlsections","perl-module","perl-tidy","plperl","perl5.12","perl5.10","bioperl","libwww-perl","mod-perl2","activeperl","wxperl","perldoc");
addAssociations("perl-scripting", \@array);

@array = ("javascript-security","javascript-debugger","javascript-execution","dynamic-javascript","javascript-engine","unobtrusive-javascript","javascript-library","javascript","javascript-injection","javascript-intellisense","javascript-performance","javascript-framework","javascript-events","javascript-toolkit","serverside-javascript","jsonarray","json-encode","json-decode","json-rpc","jsonschema","simplejson","django-json","jsonp","geojson","jsonpickle","json","getjson","ajax","google-ajax-api","jquery-ajax","drupal-ajax","ajax.net","ajaxform","ajax-polling","sajax","ajaxcontroltoolkit","xajax","reverse-ajax","ajax-upload","asp.net-ajax","microsoft-ajax","ajaxtoolkit");
addAssociations("javascript-scripting", \@array);

@array = ("bash","shell","shell-scripting","powershell","zsh","ksh","csh","tcsh","bashrc","sh",".bashrc","shellscript","bash-alias","powershell-v2.0","windows-shell", "shellexecute","wsh","shell-exec","rsh","bourne-shell","eshell",".bash-profile","zshrc","bash-script","pdksh","cshrc","shell-command","shell-extensions", "beanshell","bash2zsh","shell-script","powershell-v1.0","bash4");
addAssociations("bash-scripting", \@array);


@array = ("javascriptmvc","javascript-performance","javascript-execution","javascript-overlay","javascript-security","javascript-objects","javascript","javascript-disabled","javascript-library","javascriptserializer","javascript-alert","javascript-waiting","javascript-editor","dynamic-javascript","no-javascript","javascript-engine","javascript-toolkit","javascript-injection","javascript-debugger","serverside-javascript","javascript-events","javascript-intellisense","javascript-framework","javascript-keywords","javascript-functions","unobtrusive-javascript","javascript-validation");
addAssociations("javascript-web", \@array);

@array = ("asp.net-ajax","asp.net-session","asp.net-mvc-views","asp.net-mvc-3","asp.net-mvc-2","asp.net-mvc-partialview","asp.net-routing","asp.net-mvc-futures","asp.net-webforms","asp.net-mvc-2-preview2","asp.net-mvc-file-upload","asp.net-mvc-ajax","asp.net-roles","asp.net-development-serv","asp.net-3.5sp1","asp.net-4.0","asp.net-mvc-validation","asp.net-membership","asp.net-mvc-routing","asp.net-3.5","asp.net-ajax-toolbox","asp.net-dynamic-data","asp.net-mvc-controllers","asp.net-mvc-controller","asp.net-2.0","asp.net-mvc-2-rtm","jqgrid-asp.net","asp.net-mvc-2-validation","asp.net-charts","asp.net-1.1","asp.net-security","asp.net-mvc","asp.net","asp.net-controls","asp.net-webmethod","asp.net-mvc-beta1","asp.net-profiles","microsoft-ajax-minifier","ajaxcontroltoolkit","asp.net-ajax","google-ajax-search-api","ajaxcontext","ajaxstart","ajax-config.xml","google-ajax-api","ajax4jsf","jquery-ajax","ajaxtoolkit","ajax","google-ajax-libraries","asp.net-mvc-ajax","ajaxparts","ajax-form","ajax-request","ajax-extender","ajax-forms","ajax.net","ajax.request","asp.net-ajax-toolbox","drupal-ajax","ajaxform","sajax","reverse-ajax","google-ajax","ajax-push","ajax-on-rails","microsoft-ajax","ajax-polling","ajax-upload","ajaxtags","xajax","django-ajax-selects","radajaxmanager","flajaxian","ajax.beginform","ajaxpro");
addAssociations("asp.net-web", \@array);

@array = ("sphinx-php","php6","php5","php4","php-mysql","phpmailer","phptal","php5.3","php-oop","phpflickr","php.ini","php-compile","phpdoc","easyphp","phpquery","cakephp-1.3","cakephp-1.2","amfphp","jqgrid-php","cakephp","phpbms","phpbb3","phpdocumentor","firephp","php-security","phpbb","delphi4php","phpunit","php-parser","phpmyadmin","php-in-array","php-session","php","php-form-processing");
addAssociations("php-web", \@array);

@array = ("jquery-dynatree","jquery-chaining","jquery-layout","jquery-grid","jquery-tooltip","jquery-calculation","jquery-modal-dialog","jquery-pagination","jquery-animate","no-jquery","jquery-ui-dialog","jquery-scrollable","jquery1.4","jquery-load","jquery-selectors","jquery-sortable","jquery.ui","jquery-1.3","jquery-ajax","jquery-highlightfade","jquery-event-binding","jquery-ui","jquery-datepicker","jquery-ui-plugins","jquery-easing","jquery-accordion","jquery-performance","jquery-traversing","jquery-jscrollpane","jquerygrid","jquery-accordian","jquery-click-event","without-jquery","jquery-ui-sortable","jquery-post","jquery-events","jquery-blockui","jquery-effects","jquery-dialog","jquery-xml","jquery-color","jquery-tools","jquery.support","jquery.validate","jquery-validate","jquery-ui-button","jquery-animation","jquery-ui-datepicker","jquery-wait","jquery-live","jquery-autocomplete","jquery-ui-resizable","jquery-cookie","jquery-plugins","jquery-session","jquery-ui-autocomplete","jquery-1.4.2","jquery-1.4.1","jquery-ui-accordion","jquery-xslt-plugin","jquery-address","jquery-tabs","jquery-1.3.2","jquery-ui-tabs","jquery","jquery-frames","jquery-tmpl","jquery-object","jquery-forms-plugin","jquery-mobile","jqueryform","jquery-cycle","jquery-callback");
addAssociations("jquery-web", \@array);


@array = ("eclipse-api","eclipse-3.5.1","eclipse-plugin","eclipse","eclipse-plugin-dev","hgeclipse","eclipseme","eclipse-templates","eclipse-wtp","blackberry-eclipse-plugin","eclipse-jdt","eclipse-monkey","eclipse-plugins","eclipse-fragment","m2eclipse","myeclipse","maven-eclipse-plugin","eclipselink","eclipse-europa","eclipse-rcp","phpeclipse","cfeclipse","eclipse-rap","eclipse-ecf","eclipse-e4","eclipse-3.6","eclipse-3.5","eclipse-3.4","eclipse-3.3","eclipse-3.2","google-eclipse-plugin","eclipse-pdt","eclipse-pde","eclipse-cdt");
addAssociations("eclipse", \@array);

@array = ("netbeans","netbeans-plugins","netbeans-7","netbeans6.8","netbeans6.7","netbeans6.5","netbeans6.1","netbeans-6.9","netbeans-platform");
addAssociations("netbeans", \@array);




sub addAssociations{
    my $technologyLabel = shift;
    my @tagList = @{$_[0]};

    my $sql = "SELECT te.ID from TECHNOLOGIES te where te.LABEL=\"$technologyLabel\"";
    print "$sql\n";
    my $sth = $dbh->prepare($sql);
    $sth->execute or die "SQL Error: $DBI::errstr\n";
    my $technologyID = $sth->fetchrow_array;

    if ((length $technologyID) == 0 ){
        print "technologyLabel \"$technologyLabel\" not found in DB. Skipping.\n";
        return;
    }

    foreach my $tag (@tagList){
        $sql = "SELECT t.ID from TAGS t where t.LABEL=\"$tag\"";
        print "\n$sql\n";
        my $sth = $dbh->prepare($sql);
        $sth->execute or die "SQL Error: $DBI::errstr\n";
        my $tagID = $sth->fetchrow_array;

        if ((length $tagID) == 0 ){
            print "tagLabel \"$tag\" not found in DB. Skipping.\n";
            next;
        }

        $sql = "INSERT IGNORE INTO TECHNOLOGIES_TAGS VALUES ($technologyID, $tagID); ";
        print "$sql\n";
        $sth = $dbh->prepare($sql);
        $sth->execute or die "SQL Error: $DBI::errstr\n";
    }
}
