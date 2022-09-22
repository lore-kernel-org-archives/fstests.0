Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DDFC6FA82
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 06:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiIVGir (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 02:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiIVGip (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 02:38:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CE2B6D30
        for <fstests@vger.kernel.org>; Wed, 21 Sep 2022 23:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663828724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sztiGn6e83fbTtb5WQCkaUJeqOvb0QhoXMfH70wZ/7A=;
        b=b/WZAFTj85tq2IZGuwaoSrVWLnqtHsr3z+mHSWP/CDuPHAKwm/5GuXJB0xszYj6Be2+ioe
        QGZKkhabOR5dQoWU3BjvXwnWIL0Yk+mJ11lOPPH6QIBoUP/Jv+P5JKGGUJwv48+P8cXeUa
        ft9d/WEHrVYpxXVo6d19G/Kbdd32LEc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-324-dYPJRe9zO92hMt1pRnkjbQ-1; Thu, 22 Sep 2022 02:38:42 -0400
X-MC-Unique: dYPJRe9zO92hMt1pRnkjbQ-1
Received: by mail-ed1-f71.google.com with SMTP id b16-20020a056402279000b0044f1102e6e2so6083938ede.20
        for <fstests@vger.kernel.org>; Wed, 21 Sep 2022 23:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sztiGn6e83fbTtb5WQCkaUJeqOvb0QhoXMfH70wZ/7A=;
        b=7g1/mkHGAFqpq2wZ2w4Fnm0ScBng0NtNvOUQ+yczsuG+00l8X8Y4+s1Y2Jc8cxS8sQ
         uOOInJAOSg7HyJU/IV2/EQGxnkNiFSUUQZl7hkQqWziD4XWKQyflngRTwLbgyoDG+fL+
         oa3VqfaR0zKUqcqp9I1b7CHD+1Pvklkf4AHPnHIBQ4+HD5EsXURyqNRnOyfX/B4b4jZu
         oUT1WRfsU1ztQ63AbmLmYIXn3NrAMFixADrFoVBDhRZ1YafRuEQri27S/OFJlF3Ulj6G
         j0LDKM47VUX4AzA13De8ZV/MNja++a7lr2crXu78RUi3Prn0LqOhBVWxy/Ux++Iy8fdz
         Yn8w==
X-Gm-Message-State: ACrzQf2mTm5z5DkF/fCHBBv5HYBV4wA65UxFtWb/TTXAO06SNKevktbH
        nN1P7IZcz2/52DrVOgmC5KcG7qi1pxMQFjeo4poJs/FiCB/NXNVHprktsx18IrUtKvP6adpCF8A
        XiMUOyf/CZE/JZ3yu5R4zp4HeegSgMA+IZX18HvKUdLPFUGrRgq7Hhalqz1ALFSOte3Ps
X-Received: by 2002:a17:907:8a0b:b0:77a:be0e:f19c with SMTP id sc11-20020a1709078a0b00b0077abe0ef19cmr1455137ejc.397.1663828720046;
        Wed, 21 Sep 2022 23:38:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5FocdVroMpFy4D5+n8YJ9eAd7cSzXPq/latoSSIk5h8x1bl/YTzVJlwUO7ZW4FioU22HOOqw==
X-Received: by 2002:a17:907:8a0b:b0:77a:be0e:f19c with SMTP id sc11-20020a1709078a0b00b0077abe0ef19cmr1455128ejc.397.1663828719783;
        Wed, 21 Sep 2022 23:38:39 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id s4-20020aa7d784000000b0044838efb8f8sm3072750edq.25.2022.09.21.23.38.39
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 23:38:39 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v5 1/2] common: new helper to alloacate fixed size files
Date:   Thu, 22 Sep 2022 08:38:35 +0200
Message-Id: <20220922063836.974796-2-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922063836.974796-1-preichl@redhat.com>
References: <20220922063836.974796-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Helper that creates files of specified size using falloc if supported,
otherwise pwrite is used.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 common/rc         | 23 +++++++++++++++++++++++
 tests/generic/694 |  8 +++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index a25cbcd0..228fcb37 100644
--- a/common/rc
+++ b/common/rc
@@ -4925,6 +4925,29 @@ hexdump()
 	_fail "Use _hexdump(), please!"
 }
 
+# Try to create a file with inode->i_blocks >= (length / blocksize).
+# There may be some small overhead, e.g. ext2 filesystem allocates a
+# substantial number of blocks to store block mappings. Those are accounted
+# to i_blocks.
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
index dfd988df..c96c2154 100755
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
+	echo "Could not create 4G test file"
+fi
 
 iblocks=`stat -c '%b' $junk_file`
 
-- 
2.37.3

