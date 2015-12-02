Received: from mx1.redhat.com ([209.132.183.28]:50175 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbbLBQMB (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 2 Dec 2015 11:12:01 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 297C28F291
	for <fstests@vger.kernel.org>; Wed,  2 Dec 2015 16:12:01 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tB2GBxUl012727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Wed, 2 Dec 2015 11:12:00 -0500
From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] dmflakey: filter out 'dax' from mount options
Date: Wed, 02 Dec 2015 11:11:59 -0500
Message-ID: <x49610gq180.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

In testing with MOUNT_OPTIONS="-o dax" ./check ..., I ran into issues
with every single test that uses dmflakey.  The problem is that the
mount will fail, since we're layering a stacking driver on top of the
pmem device, and that stacking driver does not support direct access.
To fix that, I decided to filter out the dax mount option from dmflakey
mounts.  If there are suggestions for a better approach, I'm all ears.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/common/dmflakey b/common/dmflakey
index e55aefd..693d231 100644
--- a/common/dmflakey
+++ b/common/dmflakey
@@ -21,6 +21,47 @@
 FLAKEY_ALLOW_WRITES=0
 FLAKEY_DROP_WRITES=1
 
+_filter_mount_opt()
+{
+	local opts=''
+	local old_opts=$1
+	local filter=$2
+
+	# If there are no options, or if the filter isn't present,
+	# just return.
+	if [ -z "$old_opts" ]; then
+		echo -n ""
+		return
+	fi
+
+	echo $old_opts | grep -q $filter
+	if [ $? -ne 0 ]; then
+		echo -n $old_opts
+		return
+	fi
+
+	# -o, --options opts
+	#      Options are specified with a -o flag followed by a  comma  sepa-
+	#      rated string of options. For example:
+	#             mount LABEL=mydisk -o noatime,nouser
+	#
+	# There are several cases we have to handle:
+	# -o dax; -o,dax
+	# -o,ro,dax; -o,dax,ro
+	# -o,ro,dax,discard
+	#
+	opts=$(echo $old_opts | sed -e "s/$filter//g")
+	opts=$(echo $opts | sed -e 's/,,/,/g')
+	opts=$(echo $opts | sed -e 's/ ,/ /g')
+	# get rid of trailing whitespace or comma
+	opts=$(echo $opts | sed -e 's/[[:space:]]$//g')
+	opts=$(echo $opts | sed -e 's/,$//g')
+	# finally, if there's nothing left, get rid of the -o
+	opts=$(echo $opts | sed -e 's/-o$//g')
+
+	echo -n $opts
+}
+
 _init_flakey()
 {
 	local BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
@@ -34,7 +75,8 @@ _init_flakey()
 
 _mount_flakey()
 {
-	mount -t $FSTYP $MOUNT_OPTIONS $FLAKEY_DEV $SCRATCH_MNT
+	mount_options=$(_filter_mount_opt "$MOUNT_OPTIONS" dax)
+	mount -t $FSTYP $mount_options $FLAKEY_DEV $SCRATCH_MNT
 }
 
 _unmount_flakey()
