Received: from imap.thunk.org ([74.207.234.97]:52662 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751794AbdC0Bsh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 26 Mar 2017 21:48:37 -0400
Date: Sun, 26 Mar 2017 21:48:02 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [RFC PATCH] check: try to fix the test device if it gets
 corrupted
Message-ID: <20170327014802.wc5as2tdgecy3rzu@thunk.org>
References: <20170302232050.31125-1-tytso@mit.edu>
 <20170303090332.GP14226@eguan.usersys.redhat.com>
 <20170303172157.GA5070@birch.djwong.org>
 <20170303230129.apzqe77r4d5jtf63@thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170303230129.apzqe77r4d5jtf63@thunk.org>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 03, 2017 at 06:01:29PM -0500, Theodore Ts'o wrote:
> On Fri, Mar 03, 2017 at 09:21:57AM -0800, Darrick J. Wong wrote:
> >=20
> > <shrug> The test device isn't supposed to get corrupted, since it (at
> > least in theory) should be an old filesystem.  That said, I suppose
> > there's little point in banging around with a corrupt test fs.  Maybe we
> > could go further and stop running if there's unfixable corruption?
>=20
> Yes, that was the other alternative I considered.  In my case, though,
> since I'm trying to get a sense of how many failures I have to deal
> with, I really wanted a "make -k" behavior that would continue after
> the first failure.  After all, all I was going to do was manually run
> fsck, and then continue the run --- so we might as well have the check
> script do it automatically and then allow things to continue.
>=20
> We could make it be configurable, via a command-line option.  The -k
> option isn't taken so we could have check -k that works like make -k
> if you think that's better.  OTOH, perhaps making -k the default
> behaviour is actually the better way to go, and in that case, maybe
> it's not worth having the command-line flag?

Eryu, do you have any preferences or comments about how you'd like me
to modify this patch for upstreaming?  (Attached is my current version
of the patch).

Thanks!!

					- Ted

commit 727c737d1f0a40288fc897c0263fbf8e7a5db8b3
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Wed Mar 1 19:54:08 2017 -0500

    check: try to fix the test device if it gets corrupted
=20=20=20=20
    If the test device gets corrupted all subsequent tests will fail.  To
    prevent this from causing all subsequent tests to be useless, try
    repair the file system on TEST_DEV if possible.  We don't need to do
    this with the scratch device since that file system gets recreated
    each time anyway.
=20=20=20=20
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/check b/check
index 2fcf385f..d253f744 100755
--- a/check
+++ b/check
@@ -472,7 +472,11 @@ _summary()
 _check_filesystems()
 {
 	if [ -f ${RESULT_DIR}/require_test ]; then
-		_check_test_fs || err=3Dtrue
+		if ! _check_test_fs ; then
+		    err=3Dtrue
+		    echo "Trying to repair broken TEST_DEV file system"
+		    _repair_test_fs
+		fi
 		rm -f ${RESULT_DIR}/require_test*
 	fi
 	if [ -f ${RESULT_DIR}/require_scratch ]; then
diff --git a/common/rc b/common/rc
index 052f67aa..ce491f3f 100644
--- a/common/rc
+++ b/common/rc
@@ -1172,6 +1172,28 @@ _repair_scratch_fs()
     esac
 }
=20
+_repair_test_fs()
+{
+    case $FSTYP in
+    ext2|ext3|ext4)
+        fsck -t $FSTYP -fy $TEST_DEV >$tmp.repair 2>&1
+	if test $? -ge 4 ; then
+	    echo "_repair_test_fs: couldn't repair filesystem on $device (see $se=
qres.full)"
+
+	    echo "_repair_test_fs: couldn't repair filesystem on $device" >>$seqr=
es.full
+	    echo "*** fsck.$FSTYP output ***"	>>$seqres.full
+            cat $tmp.repair			>>$seqres.full
+	    echo "*** end fsck.$FSTYP output"	>>$seqres.full
+	    return 1
+	fi
+	return 0
+	;;
+    *)
+	return 1
+	;;
+    esac
+}
+
 _get_pids_by_name()
 {
     if [ $# -ne 1 ]
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3DTzkdhjUlBq8jw7ezkl6BuvazC1ulmLiwN0_zxLN0WsE&s=3DBrM0YkzpJep1zV6T-XPTWCIj=
CTjMYv_CK_yzXPCXfKY&e=3D=20
