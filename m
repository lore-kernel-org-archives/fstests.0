Return-Path: <SRS0=3sLM=AM=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E77C433DF
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jul 2020 16:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADED420780
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jul 2020 16:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbgGAQHF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:07:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:29653 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731751AbgGAQHF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 1 Jul 2020 12:07:05 -0400
IronPort-SDR: tqoqmidxw1NmQl9fyfXtR98KHKshQ721fOcN2PvUJm5rIWCvfk+eu2iTC7VxQqBmhjqrAUxEq4
 SahMldR2B0GA==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="144138159"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="144138159"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 09:07:04 -0700
IronPort-SDR: BJZKL7UETxSmh7BZsME/3TS0fmRqE8eYdbhV5ibB2n9Y0gV0RRFwe3ay54NMJpolcT3dBPP6M6
 7X3Ot05w7SwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="321797887"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga007.jf.intel.com with ESMTP; 01 Jul 2020 09:07:03 -0700
Date:   Wed, 1 Jul 2020 09:07:03 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com
Subject: Re: [PATCH v3 6/6] xfs/260: Move and update xfs/260
Message-ID: <20200701160702.GA82575@iweiny-DESK2.sc.intel.com>
References: <20200630135951.21202-1-yangx.jy@cn.fujitsu.com>
 <20200630135951.21202-7-yangx.jy@cn.fujitsu.com>
 <20200630204153.GW2617015@iweiny-DESK2.sc.intel.com>
 <5EFBDF8E.6080007@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5EFBDF8E.6080007@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 01, 2020 at 08:57:50AM +0800, Xiao Yang wrote:
> On 2020/7/1 4:41, Ira Weiny wrote:
> > On Tue, Jun 30, 2020 at 09:59:51PM +0800, Xiao Yang wrote:
> > > 1) Both ext4 and xfs have supported inode DAX flag so move it to generic.
> > > 2) Modifying inode DAX flag on flies does not take effect immediately so
> > >     make files inherit the DAX flag of parent directory.
> > > 3) Setting/clearing inode DAX flag have no chance to change S_DAX flag if
> > >     mount with dax option so remove the related subtest.
> > > 
> > > Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> > > Signed-off-by: Ira Weiny<ira.weiny@intel.com>
> > > ---
> > >   tests/{xfs/260 =>  generic/603} | 63 +++++++++++++++++-----------------
> > >   tests/generic/603.out          |  2 ++
> > >   tests/generic/group            |  1 +
> > >   tests/xfs/260.out              |  2 --
> > >   tests/xfs/group                |  1 -
> > >   5 files changed, 34 insertions(+), 35 deletions(-)
> > >   rename tests/{xfs/260 =>  generic/603} (60%)
> > >   create mode 100644 tests/generic/603.out
> > >   delete mode 100644 tests/xfs/260.out
> > > 
> > > diff --git a/tests/xfs/260 b/tests/generic/603
> > > similarity index 60%
> > > rename from tests/xfs/260
> > > rename to tests/generic/603
> > > index 7afc20f1..f40048f9 100755
> > > --- a/tests/xfs/260
> > > +++ b/tests/generic/603
> > > @@ -2,7 +2,7 @@
> > >   # SPDX-License-Identifier: GPL-2.0
> > >   # Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
> > >   #
> > > -# FS QA Test 260
> > > +# FS QA Test 603
> > >   #
> > >   # Test per-inode DAX flag by mmap direct/buffered IO.
> > >   #
> > > @@ -28,7 +28,7 @@ _cleanup()
> > >   # remove previous $seqres.full before test
> > >   rm -f $seqres.full
> > > 
> > > -_supported_fs xfs
> > > +_supported_fs generic
> > >   _supported_os Linux
> > >   _require_scratch_dax_mountopt "dax"
> > >   _require_test_program "feature"
> > > @@ -36,68 +36,72 @@ _require_test_program "t_mmap_dio"
> > >   _require_scratch_dax_iflag
> > >   _require_xfs_io_command "falloc"
> > > 
> > > -prep_files()
> > > +SRC_DIR=$SCRATCH_MNT/src
> > > +SRC_FILE=$SRC_DIR/tf_s
> > > +DST_DIR=$SCRATCH_MNT/dst
> > > +DST_FILE=$DST_DIR/tf_d
> > > +
> > > +prep_directories()
> > >   {
> > > -	rm -f $SCRATCH_MNT/tf_{s,d}
> > > +	mkdir -p $SRC_DIR $DST_DIR
> > > +}
> > > 
> > > +prep_files()
> > > +{
> > > +	rm -f $SRC_FILE $DST_FILE
> > >   	$XFS_IO_PROG -f -c "falloc 0 $tsize" \
> > > -		$SCRATCH_MNT/tf_{s,d}>>  $seqres.full 2>&1
> > > +		$SRC_FILE $DST_FILE>>  $seqres.full 2>&1
> > >   }
> > > 
> > >   t_both_dax()
> > >   {
> > > +	$XFS_IO_PROG -c "chattr +x" $SRC_DIR $DST_DIR
> > >   	prep_files
> > > -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_{s,d}
> > >   	# with O_DIRECT first
> > > -	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} $1 "dio both dax"
> > > +	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
> > > +		$1 "dio both dax"
> > > 
> > >   	prep_files
> > > -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_{s,d}
> > >   	# again with buffered IO
> > > -	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
> > > +	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
> > >   		$1 "buffered both dax"
> > >   }
> > > 
> > >   t_nondax_to_dax()
> > >   {
> > > +	$XFS_IO_PROG -c "chattr -x" $SRC_DIR
> > > +	$XFS_IO_PROG -c "chattr +x" $DST_DIR
> > >   	prep_files
> > > -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_s
> > > -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_d
> > > -	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
> > > +	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
> > >   		$1 "dio nondax to dax"
> > > 
> > >   	prep_files
> > > -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_s
> > > -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_d
> > > -	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
> > > +	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
> > >   		$1 "buffered nondax to dax"
> > >   }
> > > 
> > >   t_dax_to_nondax()
> > >   {
> > > +	$XFS_IO_PROG -c "chattr +x" $SRC_DIR
> > > +	$XFS_IO_PROG -c "chattr -x" $DST_DIR
> > >   	prep_files
> > > -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
> > > -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
> > > -	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
> > > +	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
> > >   		$1 "dio dax to nondax"
> > > 
> > >   	prep_files
> > > -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
> > > -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
> > > -	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
> > > +	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
> > >   		$1 "buffered dax to nondax"
> > >   }
> > > 
> > >   t_both_nondax()
> > >   {
> > > +	$XFS_IO_PROG -c "chattr -x" $SRC_DIR $DST_DIR
> > >   	prep_files
> > > -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_{s,d}
> > > -	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
> > > +	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
> > >   		$1 "dio both nondax"
> > > 
> > >   	prep_files
> > > -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_{s,d}
> > > -	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
> > > +	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
> > >   		$1 "buffered both nondax"
> > >   }
> > > 
> > > @@ -112,6 +116,7 @@ t_dax_flag_mmap_dio()
> > > 
> > >   do_tests()
> > >   {
> > > +	prep_directories
> > >   	# less than page size
> > >   	t_dax_flag_mmap_dio 1024
> > >   	# page size
> > > @@ -124,15 +129,9 @@ do_tests()
> > >   # make xfs aligned for PMD fault testing
> > >   _scratch_mkfs_geom $(_get_hugepagesize) 1>>  $seqres.full 2>&1
> > > 
> > > -# mount with dax option
> > > -_scratch_mount "-o dax"
> > > -
> > >   tsize=$((128 * 1024 * 1024))
> > > 
> > > -do_tests
> > > -_scratch_unmount
> > > -
> > > -# mount again without dax option
> > > +# mount without dax option
> > NIT: we could mention that this defaults to the dax=inode state for the FS
> > now...  but I don't think it is absolutely necessary.
> Hi Ira,
> 
> I am ok to add the nit. :-)
> In addition, I actaully simplify the code your provided so do you have any
> comment on this change.?

No I think what you have here is good. Thanks...

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Best Regards,
> Xiao Yang
> > Reviewed-by: Ira Weiny<ira.weiny@intel.com>
> > 
> > 
> > >   export MOUNT_OPTIONS=""
> > >   _scratch_mount
> > >   do_tests
> > > diff --git a/tests/generic/603.out b/tests/generic/603.out
> > > new file mode 100644
> > > index 00000000..6810da89
> > > --- /dev/null
> > > +++ b/tests/generic/603.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 603
> > > +Silence is golden
> > > diff --git a/tests/generic/group b/tests/generic/group
> > > index d9ab9a31..1d0d5606 100644
> > > --- a/tests/generic/group
> > > +++ b/tests/generic/group
> > > @@ -605,3 +605,4 @@
> > >   600 auto quick quota
> > >   601 auto quick quota
> > >   602 auto quick encrypt
> > > +603 auto attr quick dax
> > > diff --git a/tests/xfs/260.out b/tests/xfs/260.out
> > > deleted file mode 100644
> > > index 18ca517c..00000000
> > > --- a/tests/xfs/260.out
> > > +++ /dev/null
> > > @@ -1,2 +0,0 @@
> > > -QA output created by 260
> > > -Silence is golden
> > > diff --git a/tests/xfs/group b/tests/xfs/group
> > > index daf54add..71c30898 100644
> > > --- a/tests/xfs/group
> > > +++ b/tests/xfs/group
> > > @@ -257,7 +257,6 @@
> > >   257 auto quick clone
> > >   258 auto quick clone
> > >   259 auto quick
> > > -260 auto attr quick dax
> > >   261 auto quick quota
> > >   262 dangerous_fuzzers dangerous_scrub dangerous_online_repair
> > >   263 auto quick quota
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
