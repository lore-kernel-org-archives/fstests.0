Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F011C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Apr 2022 08:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiDYIYB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 25 Apr 2022 04:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiDYIX7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Apr 2022 04:23:59 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AE120F75
        for <fstests@vger.kernel.org>; Mon, 25 Apr 2022 01:20:53 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id v2so3133747qto.6
        for <fstests@vger.kernel.org>; Mon, 25 Apr 2022 01:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Vt9rL7QYmHhmsR3BTiaGxJbas4Ea7C2apDus1dp+3JQ=;
        b=mz3b0BSwKKoE1GVJ8S+cdqEzXaF+ot6r1mB0rl6HIr7VpFrlo4+19PRvIpjWlfvKJC
         5PDhXQJHjSXe3D9oAhd5JI2yb8X0x7N7R+aCNcza+SWAsb+xH05nFAgdKKSFR2iwWNUn
         CKumby7KndinqgipbCYXEy0YvHij2uYIc1LAjmywdLvWrlcCFpd277dhJwboRmgD/lB5
         m8++vp1+bI800rcJH0pShEEZGg51XZS3HWiEOX5S2aTIRgS2lvhkw8jrW8CxoWSSYJBc
         IA/XZFJ+wDTg4Ew3GDqyg2PWncWrb1mvwjef17PNY6Jhc7hkRhx+1JEV/9KPCvVMDKWb
         m1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Vt9rL7QYmHhmsR3BTiaGxJbas4Ea7C2apDus1dp+3JQ=;
        b=35E/ux4Do6WMe6/UxgG2B9595iUnfHLLXGF8DcZjO9Jsh/5Cq4PJ+0N0WhmJ2JDiES
         XG/F3hV62a4zc3PdZ3CP/OHocjs3QpSBfgd0A0RgImQqizFrpmyuRFdFec2wjXwlcX72
         XoFZkKXiyekfH0QCaBG7V06Tt7YwF1MptzCHf+CTT8tBhkk9YTtM43prmNqvGQUjL0J4
         94Oxmk/I1supqiHRQUIyBc5hmlWZeMb3cQ0SAb/0IUIXRlhQVmC30TdvRugZEu6VjOLZ
         o3+clBu1oAB8W0Gqy2gq2azYcSDvwla6KFHALDSVDEvZO61dvpF3nTh4OGnPMZlBEMHz
         wDhQ==
X-Gm-Message-State: AOAM5304VfMmEEjdetmrWfBVrhxr2Pb4Azo+EMJno+kkfmFKDox4OE8a
        i9Bip7g33pqPa4n31AG623tN042pPjs=
X-Google-Smtp-Source: ABdhPJx4b3ZTF+RdbWo7ti2jrZNphPLEn75zp9bqFRhMvPle1qA8mFmpEykdC0tUUcICKnCdilGUcg==
X-Received: by 2002:a05:622a:13cf:b0:2f3:6168:13c0 with SMTP id p15-20020a05622a13cf00b002f3616813c0mr6082732qtk.144.1650874852724;
        Mon, 25 Apr 2022 01:20:52 -0700 (PDT)
Received: from xzhouw.hosts.qa.psi.rdu2.redhat.com ([66.187.232.127])
        by smtp.gmail.com with ESMTPSA id a63-20020ae9e842000000b0069e6722632bsm4784853qkg.39.2022.04.25.01.20.51
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 01:20:52 -0700 (PDT)
Date:   Mon, 25 Apr 2022 16:20:51 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] chown: fix ownership format string
Message-ID: <20220425082051.2wpffz2ek3jvtd6z@xzhouw.hosts.qa.psi.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

After coreutils rebasing to 9.1, chown(1) behavior changes:
"
   chown and chroot now warn about usages like "chown root.root f",
   which have the nonstandard and long-obsolete "." separator that
   causes problems on platforms where user names contain ".".
   Applications should use ":" instead of ".".
"

https://lwn.net/Articles/891574/

With this behavior change, old format of ownership string will cause
warning like this:
"
+chown: warning: '.' should be ':': '1000.1000'
+.chown: warning: '.' should be ':': '1100.1100'
+.chown: warning: '.' should be ':': '1200.1200'
+.chown: warning: '.' should be ':': '1300.1300'
+.chown: warning: '.' should be ':': '1400.1400'
"

The new format works fine with old versions of coreutils.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 common/dump       | 6 +++---
 tests/generic/099 | 4 ++--
 tests/generic/237 | 2 +-
 tests/generic/318 | 2 +-
 tests/generic/380 | 2 +-
 tests/generic/597 | 6 +++---
 tests/generic/598 | 6 +++---
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/common/dump b/common/dump
index ea16d442..44a9a708 100644
--- a/common/dump
+++ b/common/dump
@@ -526,7 +526,7 @@ _do_create_dumpdir_fill()
 	    fi
 	fi
 	if [ -n "$owner" -a -n "$group" ]; then
-	    chown $owner.$group $file
+	    chown $owner:$group $file
 	fi
 	if [ -n "$perms" ]; then
 	    chmod $perms $file
@@ -691,10 +691,10 @@ _do_create_dump_symlinks()
 	fi
 
 	if [ -n "$owner" -a -n "$group" ]; then
-	    chown $owner.$group $file
+	    chown $owner:$group $file
 	fi
 	if [ -n "$owner" -a -n "$group" ]; then
-	    chown -h $owner.$group $file-link
+	    chown -h $owner:$group $file-link
 	fi
 	if [ -n "$perms" ]; then
 	    chmod $perms $file
diff --git a/tests/generic/099 b/tests/generic/099
index 6ba04dd8..5cdac9ab 100755
--- a/tests/generic/099
+++ b/tests/generic/099
@@ -74,7 +74,7 @@ EOF
 chmod u=rwx file1
 chmod g=rw- file1
 chmod o=r-- file1
-chown $acl1.$acl2 file1
+chown $acl1:$acl2 file1
 _acl_ls file1
 
 echo ""
@@ -264,7 +264,7 @@ do
 	touch a/$i/mumble
 done
 popd >/dev/null
-chown -R 12345.54321 root
+chown -R 12345:54321 root
 echo "Change #1..."
 _runas -u 12345 -g 54321 -- chacl -r u::rwx,g::-w-,o::--x root
 find root -print | sort | xargs chacl -l
diff --git a/tests/generic/237 b/tests/generic/237
index 93eafd84..f17e32e4 100755
--- a/tests/generic/237
+++ b/tests/generic/237
@@ -38,7 +38,7 @@ mkdir $seq.dir1
 cd $seq.dir1
 
 touch file1
-chown $acl1.$acl1 file1
+chown $acl1:$acl1 file1
 
 echo "Expect to FAIL"
 _runas -u $acl2 -g $acl2 -- setfacl -m u::rwx file1 2>&1 | sed 's/^setfacl: \/.*file1: Operation not permitted$/setfacl: file1: Operation not permitted/'
diff --git a/tests/generic/318 b/tests/generic/318
index 5edc9f35..ed50818a 100755
--- a/tests/generic/318
+++ b/tests/generic/318
@@ -72,7 +72,7 @@ _scratch_mkfs       >>$seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount
 
 touch $file
-chown $acl1.$acl1 $file
+chown $acl1:$acl1 $file
 
 # set acls from init_user_ns, to be checked from inside the userns
 setfacl -n -m u:$acl2:rw,g:$acl2:r $file
diff --git a/tests/generic/380 b/tests/generic/380
index 4993dad0..21b789dd 100755
--- a/tests/generic/380
+++ b/tests/generic/380
@@ -35,7 +35,7 @@ _chowning_file()
 	let count=$start
 	while (( count < limit )); do
 	    touch $file
-	    chown $count.$count $file
+	    chown $count:$count $file
 	    echo -n "."
 	    let count=count+delta
 	done
diff --git a/tests/generic/597 b/tests/generic/597
index aa93237e..ff985ca6 100755
--- a/tests/generic/597
+++ b/tests/generic/597
@@ -46,8 +46,8 @@ HARDLINK_PROTECTION=`sysctl -n fs.protected_hardlinks`
 test_symlink()
 {
 	ln -s $TEST_DIR/$seq/target $TEST_DIR/$seq/sticky_dir/symlink
-	chown $OTHER.$OTHER $TEST_DIR/$seq/sticky_dir
-	chown $OWNER.$OWNER $TEST_DIR/$seq/sticky_dir/symlink
+	chown $OTHER:$OTHER $TEST_DIR/$seq/sticky_dir
+	chown $OWNER:$OWNER $TEST_DIR/$seq/sticky_dir/symlink
 	# If we can read the target, we followed the link
 	_user_do "cat $TEST_DIR/$seq/sticky_dir/symlink" | _filter_test_dir
 	rm -f $TEST_DIR/$seq/sticky_dir/symlink
@@ -55,7 +55,7 @@ test_symlink()
 
 test_hardlink()
 {
-	chown $OWNER.$OWNER $TEST_DIR/$seq/target
+	chown $OWNER:$OWNER $TEST_DIR/$seq/target
 	chmod go-rw $TEST_DIR/$seq/target
 	_user_do "ln $TEST_DIR/$seq/target $TEST_DIR/$seq/sticky_dir/hardlink" \
 		| _filter_test_dir
diff --git a/tests/generic/598 b/tests/generic/598
index 160e6d4b..769c1b1a 100755
--- a/tests/generic/598
+++ b/tests/generic/598
@@ -64,16 +64,16 @@ setup_tree()
 	mkdir -p $TEST_DIR/$seq
 	mkdir -p $TEST_DIR/$seq/sticky_dir
 	chmod 1777 $TEST_DIR/$seq/sticky_dir
-	chown $USER2.$USER2 $TEST_DIR/$seq/sticky_dir
+	chown $USER2:$USER2 $TEST_DIR/$seq/sticky_dir
 
 	# Create file & fifo in that dir owned by $USER1, and open
 	# normal read/write privs for world & group
 	$XFS_IO_PROG -c "open -f $TEST_DIR/$seq/sticky_dir/file"
-	chown $USER1.$USER1 $TEST_DIR/$seq/sticky_dir/file
+	chown $USER1:$USER1 $TEST_DIR/$seq/sticky_dir/file
 	chmod o+rw $TEST_DIR/$seq/sticky_dir/file
 
 	mkfifo $TEST_DIR/$seq/sticky_dir/fifo
-	chown $USER1.$USER1 $TEST_DIR/$seq/sticky_dir/fifo
+	chown $USER1:$USER1 $TEST_DIR/$seq/sticky_dir/fifo
 	chmod o+rw $TEST_DIR/$seq/sticky_dir/fifo
 }
 
-- 
2.27.0

