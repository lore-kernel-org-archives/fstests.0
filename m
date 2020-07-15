Return-Path: <SRS0=5/bx=A2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35419C433E1
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 16:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ACAD2065D
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 16:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LR5N2hih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgGOQtv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:49:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35126 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgGOQtv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Jul 2020 12:49:51 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FFm6KU134276;
        Wed, 15 Jul 2020 15:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=liZhg/qbBYsorUYTf5UucoRNdv3STeYb+/Smx2N9f+w=;
 b=LR5N2hihjHlIos/hMl4Rq/6XQ6u8CHPoqm2k5G2I64R6KJSSi1/TFV3jzpta0WhZ2HLj
 GXT7dK2k2B7YSIQchW1ZyNhaquY4834cJYodMSOSLeN4vrIUY32Y2yjfxLKZlfehroO1
 0hXDxJWu9CKUSsk6j3+bLLuFjQTMMf22ec63nnl2f77Wl0MEMPyrfFfCbHTWECSNfmmu
 1lkSwoA2ss96qs0K6oURbaw9m3tCWrgdNzmVMOf8Za5j0Gt9PI6YZC9p2SmEVLN7/Mel
 n4py0GA0NEJnfk72K8WhExQZ597H6xEsXkUkbN3V/Up7bTG5z+Z9PNK6AFTJB08oSd+0 gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 327s65jhsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Jul 2020 15:56:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FFltq7009526;
        Wed, 15 Jul 2020 15:56:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 327q0rg518-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 15:56:33 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06FFuWhX026671;
        Wed, 15 Jul 2020 15:56:32 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jul 2020 08:56:32 -0700
Date:   Wed, 15 Jul 2020 08:56:31 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, fstests@vger.kernel.org
Subject: Re: [PATCH v6 1/7] common/rc: Introduce new helpers for DAX mount
 options and FS_XFLAG_DAX
Message-ID: <20200715155631.GL7600@magnolia>
References: <20200714094009.8654-1-yangx.jy@cn.fujitsu.com>
 <20200714094009.8654-2-yangx.jy@cn.fujitsu.com>
 <20200715015935.GG3008823@iweiny-DESK2.sc.intel.com>
 <5F0E75DE.8050508@cn.fujitsu.com>
 <20200715041559.GK3008823@iweiny-DESK2.sc.intel.com>
 <5F0E9A42.5010807@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F0E9A42.5010807@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 impostorscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150126
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 15, 2020 at 01:55:14PM +0800, Xiao Yang wrote:
> On 2020/7/15 12:15, Ira Weiny wrote:
> > On Wed, Jul 15, 2020 at 11:19:58AM +0800, Xiao Yang wrote:
> > > On 2020/7/15 9:59, Ira Weiny wrote:
> > > > On Tue, Jul 14, 2020 at 05:40:03PM +0800, Xiao Yang wrote:
> > > > > 1) _require_scratch_dax_mountopt() checks both old and new DAX mount option
> > > > > 2) _require_dax_iflag() checks FS_XFLAG_DAX
> > > > > 
> > > > > Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> > > > Reviewed-by: Ira Weiny<ira.weiny@intel.com>
> > > Hi Ira,
> > > 
> > > Do you want to check if invalid parameter is passed to
> > > _require_scratch_dax_mountopt? Thought
> > > I think it is not necessary(user should pass correct parament).
> > > Like this:
> > > [ "$mountopt" != "dax" ]&&  [ "$mountopt" != "dax=always" ]&&  _notrun
> > > "$mountopt is invalid"
> > I thought this patch was just checking if the filesystem/device supported DAX
> > such that DAX tests could run using either old _or_ new dax support...
> > But after thinking about it I think we need something more complicated.
> > 
> > Something like:
> > 
> > if ('-o dax=inode')
> > 	// FS is DAX with per file support (ie ext4 || XFS kernel>= 5.8)
> Hi Ira,
> 
> dax=inode/dax=never cannot check if underlying device supports dax, so I
> perfer to use dax=always
> For example:
> XFS:
> # mount -o dax=inode /dev/sda8 /mnt/xfstests/test/
> # mount | grep sda8
> /dev/sda8 on /mnt/xfstests/test type xfs
> (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> ...
> # mount -o dax=always /dev/sda8 /mnt/xfstests/test/
> # mount | grep sda8
> /dev/sda8 on /mnt/xfstests/test type xfs
> (rw,relatime,seclabel,attr2,dax=never,inode64,logbufs=8,logbsize=32k,noquota)
> 
> EXT4:
> # mount -o dax=inode /dev/sda8 /mnt/xfstests/test/
> # mount | grep sda8
> /dev/sda8 on /mnt/xfstests/test type ext4 (rw,relatime,seclabel,dax=inode)
> ...
> # mount -o dax=always /dev/sda8 /mnt/xfstests/test/
> mount: /mnt/xfstests/test: wrong fs type, bad option, bad superblock on
> /dev/sda8, missing codepage or helper program, or other error.
> # dmesg | grep DAX
> [597988.165120] EXT4-fs (sda8): DAX unsupported by block device.
> 
> If we want to test new dax(i.e. dax=inode, dax=always or dax=never), so pass
> "dax=always" to  _require_scratch_dax_mountopt
> If we want to test old dax  or new dax=always(either of them), so pass "dax"
> to _require_scratch_dax_mountopt

That does seem like the only way to figure out if a fs/device
combination supports dax.

The valid arguments to the _require_scratch_dax* helpers are worth
mentioning in a comment above the function, but I suspect that adding
validation code is probably overkill.

--D

> Best Regards,
> Xiao Yang
> > else if ('-o dax')
> > 	// FS is DAX (ie ext4 || XFS on kernel<  5.8)
> > else
> > 	// FS has no dax support.
> > 
> > Do we do that with 2 functions?
> > 
> > 	_require_scratch_dax_mountopt()
> > 	_require_scratch_new_dax_mountopt()
> > 
> > If both fail we are in the else clause above?
> > 
> > We can use the dax=inode because it is a new option and is not necessarily the
> > option used while running the tests.  (I think.  as I said my xfstests skills
> > are not great so I'm not always sure of the correct patterns)
> > 
> > Ira
> > 
> > > Best Regards,
> > > Xiao Yang
> > > > > ---
> > > > > 
> > > > > V5->V6:
> > > > > Simplify _require_scratch_dax_mountopt because it is enough to only check
> > > > > dax/dax=always mount option.  See the following reasons:
> > > > > 1) we cannot detect if underlying device supports dax by mounting dax=inode
> > > > >      or dax=never.
> > > > > 2) dax=always, dax=inode, dax=never are always introduced together.
> > > > > 
> > > > >    common/rc | 22 ++++++++++++++++++++++
> > > > >    1 file changed, 22 insertions(+)
> > > > > 
> > > > > diff --git a/common/rc b/common/rc
> > > > > index f17b19f2..aeec1f11 100644
> > > > > --- a/common/rc
> > > > > +++ b/common/rc
> > > > > @@ -3188,6 +3188,28 @@ _require_scratch_dax()
> > > > >    	_scratch_unmount
> > > > >    }
> > > > > 
> > > > > +# Only accept dax/dax=always mount option becasue dax=always, dax=inode
> > > > > +# and dax=never are always introduced together.
> > > > > +_require_scratch_dax_mountopt()
> > > > > +{
> > > > > +	local mountopt=$1
> > > > > +
> > > > > +	_require_scratch
> > > > > +	_scratch_mkfs>   /dev/null 2>&1
> > > > > +	_try_scratch_mount "-o $mountopt">   /dev/null 2>&1 || \
> > > > > +		_notrun "mount $SCRATCH_DEV with $mountopt failed"
> > > > > +
> > > > > +	_fs_options $SCRATCH_DEV | egrep -q "dax(=always|,|$)" || \
> > > > > +		_notrun "$SCRATCH_DEV $FSTYP does not support -o $mountopt"
> > > > > +
> > > > > +	_scratch_unmount
> > > > > +}
> > > > > +
> > > > > +_require_dax_iflag()
> > > > > +{
> > > > > +	_require_xfs_io_command "chattr" "x"
> > > > > +}
> > > > > +
> > > > >    # Does norecovery support by this fs?
> > > > >    _require_norecovery()
> > > > >    {
> > > > > -- 
> > > > > 2.21.0
> > > > > 
> > > > > 
> > > > > 
> > > > .
> > > > 
> > > 
> > > 
> > 
> > .
> > 
> 
> 
> 
