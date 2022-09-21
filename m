Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B0CECAAD8
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Sep 2022 14:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiIUOKu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 21 Sep 2022 10:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiIUOKp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Sep 2022 10:10:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7434A8E9BB
        for <fstests@vger.kernel.org>; Wed, 21 Sep 2022 07:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663769432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YmjGZRFh9+PkdhzOxnGUG+OBKn/wOWa2w0dUqNMyeT4=;
        b=BTOU11H1s4JGswZVW37IhHdk+9XS3++/lX+8tLs4j8R9MwY2H0LgD3J+JpLrj86v14u0iO
        dfpq+rYeTTTu3As6WPiQoBbt7etX1Db8pwo2HZ5TFdxCi63Qnq/twumGAXqBL/JekgM3z4
        ijk9nu/sF6rEzf0iKoeqinfqlxSM4rA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-46-C409o-6NPYmd1NvPFL0Rgg-1; Wed, 21 Sep 2022 10:10:31 -0400
X-MC-Unique: C409o-6NPYmd1NvPFL0Rgg-1
Received: by mail-ej1-f72.google.com with SMTP id sa15-20020a1709076d0f00b00781d793f51fso387811ejc.18
        for <fstests@vger.kernel.org>; Wed, 21 Sep 2022 07:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YmjGZRFh9+PkdhzOxnGUG+OBKn/wOWa2w0dUqNMyeT4=;
        b=NGBfj9cd9IMZo17ByckFrQiAMAwhuy2O9JLHBsX1un42xDqQ+0cPs/Dztd0vNseYYV
         L2bsCD03a/Ii7Dx+nBtNQerfwbjq7RqmU+0g5ruSG8mNqUBSkGI4VfGxVAAQIFtUZLu4
         C4M4HDVp2RgQ+CjokPaGzrrObrWK4fosO07LSk2kuGU5JAUf042OCYBrZJtIXlFQtE8X
         Jw8W9VT2ATfDZ68riZ6d6+d2RmD1/dMp7hJLY5xvGVF02cR++icDVxiEHFV1xEue+1co
         XoEytjRo5campi2PhVAwGZnqhJxheksk/DpXXSkz0uNW27l/UmYB/Kt7eK7B/rUh0lqG
         H4dA==
X-Gm-Message-State: ACrzQf1w4WVcoGqHdkgASf6GfoNVoA2U12BAG6S4GzXl9vAYFPBSCFT2
        2Ac7nkPffSA4G7F0oV6ZvE4SLg0QSGSN4R9mNA6Kwfr+OHZM/0ioDX3RrJtKBPKiwzTVJ7CrSQ6
        Kg+vfK4e1r+hwdBNO//0PcE1mFhglRu3LSeUXhpFPSz0RPAcEOrs3owbmnt2g3Hv7SLps
X-Received: by 2002:a17:907:72d1:b0:781:bb32:7422 with SMTP id du17-20020a17090772d100b00781bb327422mr7254228ejc.729.1663769429375;
        Wed, 21 Sep 2022 07:10:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5pXxJm/wyjb9r7IRYV2OuMBG2r5iXsHcaReAO2joXU492YxU37/6VaqD8R1dNcZn6l2Usd7Q==
X-Received: by 2002:a17:907:72d1:b0:781:bb32:7422 with SMTP id du17-20020a17090772d100b00781bb327422mr7254209ejc.729.1663769429102;
        Wed, 21 Sep 2022 07:10:29 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id mf24-20020a170906cb9800b0077fc446aaf6sm1273400ejb.202.2022.09.21.07.10.27
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 07:10:27 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v4 1/2] common: new helper to alloacate fixed size files
Date:   Wed, 21 Sep 2022 16:10:24 +0200
Message-Id: <20220921141025.920599-2-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220921141025.920599-1-preichl@redhat.com>
References: <20220921141025.920599-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Helper that creates files of specified size using falloc if supported,
otherwise pwrite is used.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 common/rc         | 22 ++++++++++++++++++++++
 tests/generic/694 |  8 +++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index a25cbcd0..3d4587b7 100644
--- a/common/rc
+++ b/common/rc
@@ -4925,6 +4925,28 @@ hexdump()
 	_fail "Use _hexdump(), please!"
 }
 
+# Try to create a file with inode->i_blocks = $length. There may be some small
+# overhead, e.g. ext2 filesystem allocates a substantial number of blocks
+# to store block mappings. Those are accounted to i_blocks.
+_create_file_sized()
+{
+	local length=$1
+	local file=$2
+	local tmp=`mktemp -u`
+	local ret=0
+
+	$XFS_IO_PROG -ft -c "falloc 0 $length" $file >$tmp.out 2>&1
+	ret=$?
+	if (grep -Eq "Operation not supported|command .* not found" $tmp.out);then
+		# fallocate isn't supported, fallback to general buffer write
+		$XFS_IO_PROG -ft -c "pwrite 0 $length" $file >$tmp.out 2>&1
+		ret=$?
+	fi
+	[ $ret -ne 0 ] && cat $tmp.out
+	rm -f $tmp.out
+	return $ret
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/generic/694 b/tests/generic/694
index dfd988df..09fb9e71 100755
--- a/tests/generic/694
+++ b/tests/generic/694
@@ -21,6 +21,9 @@ _cleanup()
 }
 
 _supported_fs generic
+_fixed_by_kernel_commit 0c336d6e33f4 \
+	"exfat: fix incorrect loading of i_blocks for large file"
+
 _require_test
 _require_fs_space $TEST_DIR $((4 * 1024 * 1024)) #kB
 
@@ -30,7 +33,10 @@ junk_dir=$TEST_DIR/$seq
 junk_file=$junk_dir/junk
 mkdir -p $junk_dir
 
-$XFS_IO_PROG -f -c "pwrite -W 0 4G" $junk_file > /dev/null
+_create_file_sized 4G $junk_file
+if [ $? -ne 0 ]; then
+	echo "_create_file_sized failed"
+fi
 
 iblocks=`stat -c '%b' $junk_file`
 
-- 
2.37.3

