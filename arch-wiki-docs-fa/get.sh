#!/bin/sh

TARGETDIR=$2

mkdir -p $TARGETDIR

cat >$TARGETDIR/index.html <<EOF
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<HTML>
	<HEAD>
		<TITLE>ArchWiki index</TITLE>
		<META http-equiv="content-type" content="text/html; charset=utf-8"/>
	</HEAD>
	<BODY>
EOF

$1/index.pl http://wiki.archlinux.ir | while read A; do
    TITLE=`echo $A | cut -d \  -f 2- | tr ' ' '_'`
    ID=`echo $A | cut -d \  -f 1`
    echo "$ID => $TITLE"
    echo "<P><A HREF='$ID.html'>$TITLE</A>" >>$TARGETDIR/index.html
    [ -f "$TARGETDIR/$ID.html" ] || wget -q "http://wiki.archlinux.ir/index.php?title=$TITLE&printable=yes" -O "$TARGETDIR/$ID.html"
done

echo "</BODY></HTML>" >>$TARGETDIR/index.html
