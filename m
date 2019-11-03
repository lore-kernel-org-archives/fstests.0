Return-Path: <SRS0=SJPO=Y3=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BE1CA9EB0
	for <linux-fstests@archiver.kernel.org>; Sun,  3 Nov 2019 16:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280682084D
	for <linux-fstests@archiver.kernel.org>; Sun,  3 Nov 2019 16:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHmEzzUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfKCQQT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 3 Nov 2019 11:16:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36727 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfKCQQT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Nov 2019 11:16:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id v19so10495573pfm.3
        for <fstests@vger.kernel.org>; Sun, 03 Nov 2019 08:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IjKIgcRgc5LcALCEdk1n9f5I6er72gAmQ5VLEwbGeZ0=;
        b=UHmEzzUDg02ymOgrcrC5UDDR8pgu2QdbHpvlrc5O4cdLgK/8bwffAkSMSwjC8PdJSG
         7M402eEMn7VbPPrCqLWlHl11gog7NID/F+MeaPRm7Gd6JMmlrFvDZL5owrRRy8S5Bs0a
         rjznwFzCCqEi0Ib3YmqPtJWQ1t48jwDLAnXdpAyR+B7CiC/SWiqCHhfiK8tGCOvXHCb5
         GrLXdhdK6iD++sKeqrGw61A/CI379C21ImDBZAMT68GEnbcTor7e7R8T1loZW5DNEcnx
         /ctKA6oWYRq3SaWtaSi7JyaUwl+J4oL5T9gv2ogVov6i0RSw2kL5jT7D+eCbAcylDrNg
         q/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IjKIgcRgc5LcALCEdk1n9f5I6er72gAmQ5VLEwbGeZ0=;
        b=jLrl35qt7CBc13XHpLxS1s0Mm7HfctLXtKEGdCO/58EfoeLUwuJ7kRYek/T3EYqlqZ
         LFMprw/Jmj5OdB4/fM2Dm2jnqVD/fC0amTP5pxxHK22pCB6rlvEUA8vrBO0dH6ubkYld
         qA0ULeHLS/zxNuhC8dzZ26eWVrKBLlpX+sOHPkbgOeYHR/bFu9ftcgFOns8qmzXXXx0a
         LvPzevRHxY6bUfq74hg9f8psOHe/0+HI0Ju1U6/1aQVz+Fw/r5qgCfQ9rf3ONuOqKJhf
         ubxdOjZOt7wgpqdEg5836xeJxT9jwwSHyWm/kNp1aPiKEsrh73DJpbHQZ5Wc8Ud5AI2S
         Yt0A==
X-Gm-Message-State: APjAAAU4wUDcNnF60bf0I2FjxdTS285elZYupvfKwqz33/6vry9k2Wqn
        uJc7wv3sHFHvktW0r2BPTTU=
X-Google-Smtp-Source: APXvYqy2UD4yPjnSd7UYEltDgjiBMpzOEF8XwWnQMbIEmt76e6IOY4qdOaLu3KevC+U/ehQVDWDudA==
X-Received: by 2002:a63:6506:: with SMTP id z6mr12686445pgb.65.1572797776909;
        Sun, 03 Nov 2019 08:16:16 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id z7sm6444770pgk.10.2019.11.03.08.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 08:16:15 -0800 (PST)
Date:   Mon, 4 Nov 2019 00:15:59 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs: make sure the kernel and repair tools catch bad
 names
Message-ID: <20191103161540.GB8664@desktop>
References: <20191029222948.GA15224@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029222948.GA15224@magnolia>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 29, 2019 at 03:29:48PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Make sure we actually catch bad names in the kernel.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  tests/xfs/749     |  137 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/749.out |   50 +++++++++++++++++++
>  tests/xfs/group   |    1 
>  3 files changed, 188 insertions(+)
>  create mode 100755 tests/xfs/749
>  create mode 100644 tests/xfs/749.out
> 
> diff --git a/tests/xfs/749 b/tests/xfs/749
> new file mode 100755
> index 00000000..a8353cc2
> --- /dev/null
> +++ b/tests/xfs/749
> @@ -0,0 +1,137 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0-or-newer
> +# Copyright (c) 2019, Oracle and/or its affiliates.  All Rights Reserved.
> +#
> +# FS QA Test No. 749
> +#
> +# See if we catch corrupt directory names or attr names with nulls or slashes
> +# in them.
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1    # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	$UMOUNT_PROG $mntpt > /dev/null 2>&1
> +	test -n "$loopdev" && _destroy_loop_device $loopdev > /dev/null 2>&1
> +	rm -r -f $imgfile $mntpt $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/attr
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_supported_os Linux
> +_require_test
> +_require_attrs
> +_require_xfs_mkfs_crc
> +_disable_dmesg_check
> +
> +rm -f $seqres.full
> +
> +imgfile=$TEST_DIR/img-$seq
> +mntpt=$TEST_DIR/mount-$seq
> +testdir=$mntpt/testdir
> +testfile=$mntpt/testfile
> +nullstr="too_many_beans"
> +slashstr="are_bad_for_you"
> +test_names=("something" "$nullstr" "$slashstr" "another")
> +
> +# Format image file w/o crcs so we can sed the image file
> +$XFS_IO_PROG -f -c 'truncate 40m' $imgfile
> +loopdev=$(_create_loop_device $imgfile)
> +MKFS_OPTIONS="-m crc=0" _mkfs_dev $loopdev >> $seqres.full

I see the following failures after forcing it crc=0 with v5.4-rc4
kernel, just want to make sure if that's all expected?

 attr_get: No data available
 Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile
 ++ ACCESSING BAD METADATA
-ls: reading directory 'TEST_DIR/mount-148/testdir': Structure needs cleaning
+ls: reading directory 'TEST_DIR/mount-148/testdir': Input/output error
 f_something
-attr_list: Structure needs cleaning
+f_too_many
+Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
+Attribute "a_are_bad/for_you" has a 3 byte value for TEST_DIR/mount-148/testfile
+Attribute "a_another" has a 3 byte value for TEST_DIR/mount-148/testfile
 TEST_DIR/mount-148/testdir/f_something
 Attribute "a_something" had a 3 byte value for TEST_DIR/mount-148/testfile:
 heh

Thanks,
Eryu

> +
> +# Mount image file
> +mkdir -p $mntpt
> +_mount $loopdev $mntpt
> +
> +echo "creating entries" >> $seqres.full
> +
> +# Create directory entries
> +mkdir -p $testdir
> +for name in "${test_names[@]}"; do
> +	touch "$testdir/f_$name"
> +done
> +
> +# Create attrs
> +touch $testfile
> +for name in "${test_names[@]}"; do
> +	$ATTR_PROG -s "a_$name" -V heh $testfile >> $seqres.full
> +done
> +
> +# Now put in the first part of the garbage names to make sure we can't
> +# access those directly
> +test_names+=("too_many" "are_bad/for_you")
> +
> +access_stuff() {
> +	ls $testdir
> +	$ATTR_PROG -l $testfile
> +
> +	for name in "${test_names[@]}"; do
> +		ls "$testdir/f_$name"
> +		$ATTR_PROG -g "a_$name" $testfile
> +	done
> +}
> +
> +# Does it work?
> +echo "++ ACCESSING GOOD METADATA" | tee -a $seqres.full
> +access_stuff > $tmp.log 2>&1
> +cat $tmp.log >> $seqres.full
> +cat $tmp.log | _filter_test_dir
> +
> +# Corrupt the entries
> +$UMOUNT_PROG $mntpt
> +_destroy_loop_device $loopdev
> +cp $imgfile $imgfile.old
> +sed -b \
> +	-e "s/$nullstr/too_many\x00beans/g" \
> +	-e "s/$slashstr/are_bad\/for_you/g" \
> +	-i $imgfile
> +test "$(md5sum < $imgfile)" != "$(md5sum < $imgfile.old)" ||
> +	_fail "sed failed to change the image file?"
> +rm -f $imgfile.old
> +loopdev=$(_create_loop_device $imgfile)
> +_mount $loopdev $mntpt
> +
> +# Try to access the corrupt metadata
> +echo "++ ACCESSING BAD METADATA" | tee -a $seqres.full
> +access_stuff > $tmp.log 2>&1
> +cat $tmp.log >> $seqres.full
> +cat $tmp.log | _filter_test_dir | sed -e '/Could not list/d'
> +
> +echo "does scrub complain?" >> $seqres.full
> +
> +# Does scrub complain about this?
> +if _supports_xfs_scrub $mntpt $loopdev; then
> +	$XFS_SCRUB_PROG -n $mntpt >> $seqres.full 2>&1
> +	res=$?
> +	test $((res & 1)) -eq 0 && \
> +		echo "scrub failed to report corruption ($res)"
> +fi
> +
> +echo "does repair complain?" >> $seqres.full
> +
> +# Does repair complain about this?
> +$UMOUNT_PROG $mntpt
> +$XFS_REPAIR_PROG -n $loopdev >> $seqres.full 2>&1
> +res=$?
> +test $res -eq 1 || \
> +	echo "repair failed to report corruption ($res)"
> +
> +_destroy_loop_device $loopdev
> +loopdev=
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/749.out b/tests/xfs/749.out
> new file mode 100644
> index 00000000..ab7b7dc6
> --- /dev/null
> +++ b/tests/xfs/749.out
> @@ -0,0 +1,50 @@
> +QA output created by 749
> +++ ACCESSING GOOD METADATA
> +f_another
> +f_are_bad_for_you
> +f_something
> +f_too_many_beans
> +Attribute "a_something" has a 3 byte value for TEST_DIR/mount-749/testfile
> +Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-749/testfile
> +Attribute "a_are_bad_for_you" has a 3 byte value for TEST_DIR/mount-749/testfile
> +Attribute "a_another" has a 3 byte value for TEST_DIR/mount-749/testfile
> +TEST_DIR/mount-749/testdir/f_something
> +Attribute "a_something" had a 3 byte value for TEST_DIR/mount-749/testfile:
> +heh
> +TEST_DIR/mount-749/testdir/f_too_many_beans
> +Attribute "a_too_many_beans" had a 3 byte value for TEST_DIR/mount-749/testfile:
> +heh
> +TEST_DIR/mount-749/testdir/f_are_bad_for_you
> +Attribute "a_are_bad_for_you" had a 3 byte value for TEST_DIR/mount-749/testfile:
> +heh
> +TEST_DIR/mount-749/testdir/f_another
> +Attribute "a_another" had a 3 byte value for TEST_DIR/mount-749/testfile:
> +heh
> +ls: cannot access 'TEST_DIR/mount-749/testdir/f_too_many': No such file or directory
> +attr_get: No data available
> +Could not get "a_too_many" for TEST_DIR/mount-749/testfile
> +ls: cannot access 'TEST_DIR/mount-749/testdir/f_are_bad/for_you': No such file or directory
> +attr_get: No data available
> +Could not get "a_are_bad/for_you" for TEST_DIR/mount-749/testfile
> +++ ACCESSING BAD METADATA
> +ls: reading directory 'TEST_DIR/mount-749/testdir': Structure needs cleaning
> +f_something
> +attr_list: Structure needs cleaning
> +TEST_DIR/mount-749/testdir/f_something
> +Attribute "a_something" had a 3 byte value for TEST_DIR/mount-749/testfile:
> +heh
> +ls: cannot access 'TEST_DIR/mount-749/testdir/f_too_many_beans': No such file or directory
> +attr_get: No data available
> +Could not get "a_too_many_beans" for TEST_DIR/mount-749/testfile
> +ls: cannot access 'TEST_DIR/mount-749/testdir/f_are_bad_for_you': No such file or directory
> +attr_get: No data available
> +Could not get "a_are_bad_for_you" for TEST_DIR/mount-749/testfile
> +TEST_DIR/mount-749/testdir/f_another
> +Attribute "a_another" had a 3 byte value for TEST_DIR/mount-749/testfile:
> +heh
> +ls: cannot access 'TEST_DIR/mount-749/testdir/f_too_many': No such file or directory
> +attr_get: No data available
> +Could not get "a_too_many" for TEST_DIR/mount-749/testfile
> +ls: cannot access 'TEST_DIR/mount-749/testdir/f_are_bad/for_you': No such file or directory
> +Attribute "a_are_bad/for_you" had a 3 byte value for TEST_DIR/mount-749/testfile:
> +heh
> diff --git a/tests/xfs/group b/tests/xfs/group
> index f4ebcd8c..9600cb4e 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -507,3 +507,4 @@
>  509 auto ioctl
>  510 auto ioctl quick
>  511 auto quick quota
> +749 auto quick fuzzers
