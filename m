Return-Path: <SRS0=LCFT=BQ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD9CC433E0
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Aug 2020 17:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DAFE221E3
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Aug 2020 17:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgHFRt2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:49:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:61782 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbgHFQeQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 6 Aug 2020 12:34:16 -0400
IronPort-SDR: sX96oFxhVK0N04KVgHDEFUqE8p11UOU0Yd6Ob1SlhbIDIvvrSRsLoBDtUH/Jj1E1kMRAc8K3rA
 C3RIWzD1AYvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="150583710"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="150583710"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 09:09:22 -0700
IronPort-SDR: EP/uYxDrTfw0JReomrah7gYT+yKOpj90ia2Co0OyBrTEE0Ub5DyosFQJVJvQVTGC0om/5HvQJe
 PUMxUWAb56zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="493248956"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga006.fm.intel.com with ESMTP; 06 Aug 2020 09:09:22 -0700
Date:   Thu, 6 Aug 2020 09:09:22 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        fstests@vger.kernel.org, guaneryu@gmail.com
Subject: Re: [PATCH] generic: Verify how to change the S_DAX flag on an
 existing file
Message-ID: <20200806160921.GJ1573827@iweiny-DESK2.sc.intel.com>
References: <20200804011140.26674-1-yangx.jy@cn.fujitsu.com>
 <20200804153841.GC1203354@magnolia>
 <5F2A0401.90708@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F2A0401.90708@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Aug 05, 2020 at 08:57:37AM +0800, Xiao Yang wrote:
> On 2020/8/4 23:38, Darrick J. Wong wrote:
> > On Tue, Aug 04, 2020 at 09:11:40AM +0800, Xiao Yang wrote:
> > > Change FS_XFLAG_DAX on an existing file and check if S_DAX on the
> > > file can take effect immediately by the following steps:
> > > 1) Stop all applications which are using the file.
> > > 2) Do drop_caches or umount&  mount cycle.
> > Slightly related question: is there a test to check that if a filesystem
> > recognizes dax=always, it will also accept dax=inode and dax=none?  This
> > test checks that dax=always and dax=inode work, but I don't think I saw
> > one that tests dax=always ensuring that dax=none works too.
> Hi Darrick,
> 
> Good question.  dax=inode and dax=none have the same behavior so do you want
> to
> add another combination(-o dax=none)  for all tests which include dax=inode?
> Right?

FWIW, it is '-o dax=never'

I had a test for dax=never as well.  Basically FS_XFLAG_DAX=n should result in
S_DAX=y in that case.

I think this patch is good for what it does though.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Ira

> 
> Thanks,
> Xiao Yang
> > > Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> > Seems decent otherwise,
> > Reviewed-by: Darrick J. Wong<darrick.wong@oracle.com>
> > 
> > --D
> > 
> > > ---
> > > 
> > > Note: It is based on the following patch set:
> > > https://www.spinics.net/lists/fstests/msg14457.html
> > > 
> > >   tests/generic/608     | 110 ++++++++++++++++++++++++++++++++++++++++++
> > >   tests/generic/608.out |   2 +
> > >   tests/generic/group   |   1 +
> > >   3 files changed, 113 insertions(+)
> > >   create mode 100644 tests/generic/608
> > >   create mode 100644 tests/generic/608.out
> > > 
> > > diff --git a/tests/generic/608 b/tests/generic/608
> > > new file mode 100644
> > > index 00000000..33c5235d
> > > --- /dev/null
> > > +++ b/tests/generic/608
> > > @@ -0,0 +1,110 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2020 Fujitsu.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 608
> > > +# Change FS_XFLAG_DAX on an existing file and check if S_DAX on
> > > +# the file can take effect immediately by the following steps:
> > > +# 1) Stop all applications which are using the file.
> > > +# 2) Do drop_caches or umount&  mount cycle.
> > > +
> > > +seq=`basename $0`
> > > +seqres=$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +here=`pwd`
> > > +tmp=/tmp/$$
> > > +status=1        # failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +	cd /
> > > +	rm -f $tmp.*
> > > +}
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +
> > > +# remove previous $seqres.full before test
> > > +rm -f $seqres.full
> > > +
> > > +_supported_fs generic
> > > +_supported_os Linux
> > > +_require_scratch_dax_mountopt "dax=always"
> > > +_require_dax_iflag
> > > +_require_xfs_io_command "lsattr" "-v"
> > > +_require_xfs_io_command "statx" "-r"
> > > +
> > > +test_drop_caches()
> > > +{
> > > +	local t_file=$SCRATCH_MNT/testfile
> > > +
> > > +	rm -f $t_file
> > > +	touch $t_file
> > > +	_check_xflag $t_file 0
> > > +	_check_s_dax $t_file 0
> > > +
> > > +	exec 3<  $t_file
> > > +
> > > +	$XFS_IO_PROG -c 'chattr +x' $t_file
> > > +	_check_xflag $t_file 1
> > > +	_check_s_dax $t_file 0
> > > +
> > > +	# One application is using test file and check if S_DAX on
> > > +	# the file doesn't take effect immediately by drop_caches
> > > +	echo 2>  /proc/sys/vm/drop_caches
> > > +	_check_s_dax $t_file 0
> > > +
> > > +	exec 3<&-
> > > +
> > > +	# No application is using test file and check if S_DAX on
> > > +	# the file takes effect immediately by drop_caches
> > > +	echo 2>  /proc/sys/vm/drop_caches
> > > +	_check_s_dax $t_file 1
> > > +}
> > > +
> > > +test_cycle_mount()
> > > +{
> > > +	local t_dir=$SCRATCH_MNT/testdir
> > > +	local t_file=$t_dir/testfile
> > > +
> > > +	mkdir -p $t_dir
> > > +	$XFS_IO_PROG -c 'chattr +x' $t_dir
> > > +	rm -f $t_file
> > > +	touch $t_file
> > > +	_check_xflag $t_file 1
> > > +	_check_s_dax $t_file 1
> > > +
> > > +	exec 3<  $t_file
> > > +
> > > +	$XFS_IO_PROG -c 'chattr -x' $t_file
> > > +	_check_xflag $t_file 0
> > > +	_check_s_dax $t_file 1
> > > +
> > > +	exec 3<&-
> > > +
> > > +	# No application is using test file and check if S_DAX on
> > > +	# the file takes effect immediately by umount&  mount
> > > +	_scratch_cycle_mount "dax=inode"
> > > +	_check_s_dax $t_file 0
> > > +}
> > > +
> > > +do_tests()
> > > +{
> > > +	test_drop_caches
> > > +
> > > +	test_cycle_mount
> > > +}
> > > +
> > > +_scratch_mkfs>>  $seqres.full 2>&1
> > > +
> > > +_scratch_mount "-o dax=inode"
> > > +
> > > +do_tests
> > > +
> > > +# success, all done
> > > +echo "Silence is golden"
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/608.out b/tests/generic/608.out
> > > new file mode 100644
> > > index 00000000..1e534458
> > > --- /dev/null
> > > +++ b/tests/generic/608.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 608
> > > +Silence is golden
> > > diff --git a/tests/generic/group b/tests/generic/group
> > > index 5bd289c3..aa969bcb 100644
> > > --- a/tests/generic/group
> > > +++ b/tests/generic/group
> > > @@ -610,3 +610,4 @@
> > >   605 auto attr quick dax
> > >   606 auto attr quick dax
> > >   607 auto attr quick dax
> > > +608 auto attr quick dax
> > > -- 
> > > 2.21.0
> > > 
> > > 
> > > 
> > 
> > .
> > 
> 
> 
> 
