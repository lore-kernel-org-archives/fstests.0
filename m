Return-Path: <SRS0=5/bx=A2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3F5C433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 16:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7288420663
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 16:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EguVfo1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgGOQNI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:13:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49322 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgGOQNH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Jul 2020 12:13:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FGCLAr000739;
        Wed, 15 Jul 2020 16:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=SoOlnDVebQCxNPZoX70f2dRpBrMxgipd4tVq6Knq96g=;
 b=EguVfo1Jua1Je9dMfkEYYPOsHoJ9ApH209Nd5EPPR0errnu0cGD7DrCJ6/QOTtaM+8e6
 7TL+6J7cXpo09itt2OGzmw1IXe2UvqiErPtyDEjRF3u2QcYyjXEy1IjGQw35kEIdBo1C
 DFeC7FbaI17RWtlGtZI4/wkM5kxNPikklY7ZlgsU/uLC/HR0K3i6GvIqGltqBPVXwxFb
 KquVziVIJmpSpFP4yXA3l427K4/+3czkMvQ7Q3FD5VVsbFaEdl+hFFgjNVLuMWY0Chml
 JApaTPCLydNE+cTmqKmzuibHwFueNvquAPYWb2uidd3uQWdcI1a6S9xkgai1KkW2ZdeA 6Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3274urcedg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Jul 2020 16:12:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FFlrMX099841;
        Wed, 15 Jul 2020 16:10:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 327qb821qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 16:10:57 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06FGAvEh010312;
        Wed, 15 Jul 2020 16:10:57 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jul 2020 09:10:57 -0700
Date:   Wed, 15 Jul 2020 09:10:56 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, ira.weiny@intel.com
Subject: Re: [PATCH v6 5/7] xfs/260: Move and update xfs/260
Message-ID: <20200715161056.GP7600@magnolia>
References: <20200714094009.8654-1-yangx.jy@cn.fujitsu.com>
 <20200714094009.8654-6-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714094009.8654-6-yangx.jy@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=1 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=1 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150127
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 14, 2020 at 05:40:07PM +0800, Xiao Yang wrote:
> 1) Both ext4 and xfs have supported FS_XFLAG_DAX so move it to generic.
> 2) Modifying FS_XFLAG_DAX on flies does not take effect immediately so
>    make files inherit the DAX state of parent directory.
> 3) Setting/clearing FS_XFLAG_DAX have no chance to change S_DAX flag if
>    mount with dax option so remove the related subtest.
> 4) Setting/clearing FS_XFLAG_DAX doesn't change S_DAX flag on older xfs
>    due to commit 742d84290739 ("xfs: disable per-inode DAX flag") so
>    only do test when fs supports new dax=inode option.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  tests/{xfs/260 => generic/603} | 68 +++++++++++++++++-----------------

Ooh renaming detection, nice...

Looks fine to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

>  tests/generic/603.out          |  2 +
>  tests/generic/group            |  1 +
>  tests/xfs/260.out              |  2 -
>  tests/xfs/group                |  1 -
>  5 files changed, 36 insertions(+), 38 deletions(-)
>  rename tests/{xfs/260 => generic/603} (57%)
>  create mode 100644 tests/generic/603.out
>  delete mode 100644 tests/xfs/260.out
> 
> diff --git a/tests/xfs/260 b/tests/generic/603
> similarity index 57%
> rename from tests/xfs/260
> rename to tests/generic/603
> index 81b42f01..5dabe447 100755
> --- a/tests/xfs/260
> +++ b/tests/generic/603
> @@ -2,7 +2,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
>  #
> -# FS QA Test 260
> +# FS QA Test 603
>  #
>  # Test per-inode DAX flag by mmap direct/buffered IO.
>  #
> @@ -28,76 +28,80 @@ _cleanup()
>  # remove previous $seqres.full before test
>  rm -f $seqres.full
>  
> -_supported_fs xfs
> +_supported_fs generic
>  _supported_os Linux
> -_require_scratch_dax_mountopt "dax"
> +_require_scratch_dax_mountopt "dax=always"
>  _require_test_program "feature"
>  _require_test_program "t_mmap_dio"
>  _require_dax_iflag
>  _require_xfs_io_command "falloc"
>  
> -prep_files()
> +SRC_DIR=$SCRATCH_MNT/src
> +SRC_FILE=$SRC_DIR/tf_s
> +DST_DIR=$SCRATCH_MNT/dst
> +DST_FILE=$DST_DIR/tf_d
> +
> +prep_directories()
>  {
> -	rm -f $SCRATCH_MNT/tf_{s,d}
> +	mkdir -p $SRC_DIR $DST_DIR
> +}
>  
> +prep_files()
> +{
> +	rm -f $SRC_FILE $DST_FILE
>  	$XFS_IO_PROG -f -c "falloc 0 $tsize" \
> -		$SCRATCH_MNT/tf_{s,d} >> $seqres.full 2>&1
> +		$SRC_FILE $DST_FILE >> $seqres.full 2>&1
>  }
>  
>  t_both_dax()
>  {
> +	$XFS_IO_PROG -c "chattr +x" $SRC_DIR $DST_DIR
>  	prep_files
> -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_{s,d}
>  	# with O_DIRECT first
> -	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} $1 "dio both dax"
> +	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
> +		$1 "dio both dax"
>  
>  	prep_files
> -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_{s,d}
>  	# again with buffered IO
> -	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
> +	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
>  		$1 "buffered both dax"
>  }
>  
>  t_nondax_to_dax()
>  {
> +	$XFS_IO_PROG -c "chattr -x" $SRC_DIR
> +	$XFS_IO_PROG -c "chattr +x" $DST_DIR
>  	prep_files
> -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_s
> -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_d
> -	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
> +	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
>  		$1 "dio nondax to dax"
>  
>  	prep_files
> -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_s
> -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_d
> -	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
> +	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
>  		$1 "buffered nondax to dax"
>  }
>  
>  t_dax_to_nondax()
>  {
> +	$XFS_IO_PROG -c "chattr +x" $SRC_DIR
> +	$XFS_IO_PROG -c "chattr -x" $DST_DIR
>  	prep_files
> -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
> -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
> -	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
> +	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
>  		$1 "dio dax to nondax"
>  
>  	prep_files
> -	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
> -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
> -	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
> +	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
>  		$1 "buffered dax to nondax"
>  }
>  
>  t_both_nondax()
>  {
> +	$XFS_IO_PROG -c "chattr -x" $SRC_DIR $DST_DIR
>  	prep_files
> -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_{s,d}
> -	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
> +	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
>  		$1 "dio both nondax"
>  
>  	prep_files
> -	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_{s,d}
> -	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
> +	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
>  		$1 "buffered both nondax"
>  }
>  
> @@ -112,6 +116,7 @@ t_dax_flag_mmap_dio()
>  
>  do_tests()
>  {
> +	prep_directories
>  	# less than page size
>  	t_dax_flag_mmap_dio 1024
>  	# page size
> @@ -124,17 +129,10 @@ do_tests()
>  # make xfs aligned for PMD fault testing
>  _scratch_mkfs_geom $(_get_hugepagesize) 1 >> $seqres.full 2>&1
>  
> -# mount with dax option
> -_scratch_mount "-o dax"
> -
>  tsize=$((128 * 1024 * 1024))
>  
> -do_tests
> -_scratch_unmount
> -
> -# mount again without dax option
> -export MOUNT_OPTIONS=""
> -_scratch_mount
> +# mount with dax=inode option
> +_scratch_mount "-o dax=inode"
>  do_tests
>  
>  # success, all done
> diff --git a/tests/generic/603.out b/tests/generic/603.out
> new file mode 100644
> index 00000000..6810da89
> --- /dev/null
> +++ b/tests/generic/603.out
> @@ -0,0 +1,2 @@
> +QA output created by 603
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index d9ab9a31..1d0d5606 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -605,3 +605,4 @@
>  600 auto quick quota
>  601 auto quick quota
>  602 auto quick encrypt
> +603 auto attr quick dax
> diff --git a/tests/xfs/260.out b/tests/xfs/260.out
> deleted file mode 100644
> index 18ca517c..00000000
> --- a/tests/xfs/260.out
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -QA output created by 260
> -Silence is golden
> diff --git a/tests/xfs/group b/tests/xfs/group
> index daf54add..71c30898 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -257,7 +257,6 @@
>  257 auto quick clone
>  258 auto quick clone
>  259 auto quick
> -260 auto attr quick dax
>  261 auto quick quota
>  262 dangerous_fuzzers dangerous_scrub dangerous_online_repair
>  263 auto quick quota
> -- 
> 2.21.0
> 
> 
> 
