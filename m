Return-Path: <SRS0=2A/Q=7X=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5A2C433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Jun 2020 16:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63AE206F4
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Jun 2020 16:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="serw2rLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgFJQhR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:37:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48412 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgFJQhP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Jun 2020 12:37:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AGaaDg075200;
        Wed, 10 Jun 2020 16:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=DdDmDrlNP71G2C0e7oDCm5AtBjmer9qf7TM55BbJH8c=;
 b=serw2rLBmKXrqpnMVgMGbOAKBI0zohSVOkBV3P8d0uMNq/Bf06dh7Ty/vMZvsLBalktU
 gDFKB8Q7co+S2hRNxdT9uEkoMKC8d9NnLynTwFtACQF0hNP7xpmWF0gOgsLUJPMYYORr
 xKh3L5eEltLpEi0Q+gjdk0oSWH7YbxZHI8qh0PdRk0C6Vd4dysCexL38hkxPonvQZIHO
 Xf8ZD8H9IL1NMbLsXk4Cvl8IOe4oBmHjqg4GU7eHGCG22K5QZ/H7Lmqn1s42vWF0x6Ll
 +zt7jvXYmKmjIdVJ0Ye/KlPVVCMgIpLYIy75NXwT7fCvOVvUL670kc0McCMO5PjSwbYh 2g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31g3sn3a4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Jun 2020 16:37:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AGYS7x161082;
        Wed, 10 Jun 2020 16:37:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31gmwth1cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 16:37:08 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05AGb8DV030228;
        Wed, 10 Jun 2020 16:37:08 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Jun 2020 09:37:08 -0700
Date:   Wed, 10 Jun 2020 09:37:05 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, ira.weiny@intel.com
Subject: Re: [PATCH 1/4] common/rc: Introduce new helpers for DAX mount
 options and FS_XFLAG_DAX
Message-ID: <20200610163705.GC11242@magnolia>
References: <20200603140115.30392-1-yangx.jy@cn.fujitsu.com>
 <20200609163908.GA11255@magnolia>
 <5EE03F16.3030402@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5EE03F16.3030402@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=1
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100126
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 10, 2020 at 10:01:58AM +0800, Xiao Yang wrote:
> Hi Darrick,
> 
> Thanks a lot for your comments.
> 
> On 2020/6/10 0:39, Darrick J. Wong wrote:
> > Oh, this wasn't the cover letter. ;)
> 
> I will add the cover letter.
> 
> > 
> > On Wed, Jun 03, 2020 at 10:01:12PM +0800, Xiao Yang wrote:
> > > 1) _require_scratch_dax_mountopt() checks both old and new DAX mount option
> > > 2) _require_scratch_daX_iflag() checks FS_XFLAG_DAX
> > > 
> > > Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> > > ---
> > >   common/rc | 35 +++++++++++++++++++++++++++++++++++
> > >   1 file changed, 35 insertions(+)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index a6967831..ec7c19e4 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -3188,6 +3188,41 @@ _require_scratch_dax()
> > >   	_scratch_unmount
> > >   }
> > > 
> > > +_require_scratch_dax_mountopt()
> > > +{
> > > +	local mountopt=$1
> > > +	local output
> > > +
> > > +	_require_scratch
> > > +	_scratch_mkfs>  /dev/null 2>&1
> > > +	_try_scratch_mount -o "$mountopt" || \
> > > +		_notrun "mount $SCRATCH_DEV with $mountopt failed"
> > 
> > What happens if MOUNT_OPTS already contains a dax option?  Should we
> > clear it out ala _qmount_option, on the assumption that a test that
> > cares about specific options probably wants to override whatever the
> > test runner passed in?
> 
> Good point, but it seems that the last dax option is actually used if we
> mount with multiple dax options, as below:
> ----------------------------------------------
> ext4:
> # blkid /dev/pmem1
> /dev/pmem1: UUID="cd2eb9f0-af2a-4c89-a381-4d2d9d2e8054" TYPE="ext4"
> # mount -o dax -odax=inode /dev/pmem1 /mnt/xfstests/scratch/
> # mount | grep pmem1
> /dev/pmem1 on /mnt/xfstests/scratch type ext4
> (rw,relatime,seclabel,dax=inode)
> 
> # mount -o dax=never -odax=inode -odax=always /dev/pmem1
> /mnt/xfstests/scratch/
> # mount | grep pmem1
> /dev/pmem1 on /mnt/xfstests/scratch type ext4
> (rw,relatime,seclabel,dax=always)
> 
> # mount -o dax=never -odax /dev/pmem1 /mnt/xfstests/scratch/
> # mount | grep pmem1
> /dev/pmem1 on /mnt/xfstests/scratch type ext4
> (rw,relatime,seclabel,dax=always)
> 
> 
> xfs:
> # blkid /dev/pmem0
> /dev/pmem0: UUID="bc830790-1ea8-48fb-9cda-7d5bb96b8961" TYPE="xfs"
> # mount -o dax=never -o dax=always /dev/pmem0 /mnt/xfstests/test/
> # mount | grep pmem0
> /dev/pmem0 on /mnt/xfstests/test type xfs (rw,relatime,seclabel,attr2,dax=always,inode64,logbufs=8,logbsize=32k,noquota)
> 
> # mount -o dax=never -o dax=inode /dev/pmem0 /mnt/xfstests/test/
> # mount | grep pmem0
> /dev/pmem0 on /mnt/xfstests/test type xfs
> (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> 
> # mount -o dax=always -o dax=inode -o dax=never /dev/pmem0
> /mnt/xfstests/test/
> # mount | grep pmem0
> /dev/pmem0 on /mnt/xfstests/test type xfs
> (rw,relatime,seclabel,attr2,dax=never,inode64,logbufs=8,logbsize=32k,noquota)
> ----------------------------------------------
> all dax options are exclusive, so do you think is it necessary to implement
> a function as _qmount_option?

Heh, ok, I guess we don't complain about respecified mount options, so
(at least for fstests) the current behavior is ok.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> Best Regards,
> Xiao Yang
> > 
> > --D
> > 
> > > +
> > > +	output=$(_fs_options $SCRATCH_DEV)
> > > +
> > > +	# For new dax mount option, /proc/mounts shows different outputs if we
> > > +	# mount with -o dax=inode on ext4 and xfs so skip checking it.
> > > +	# /proc/mounts shows 'dax=inode' on ext4 but shows nothing on xfs.
> > > +	if [ "$mountopt" != "dax=inode" ]; then
> > > +		echo $output | grep -qw "$mountopt" || \
> > > +			_notrun "$SCRATCH_DEV $FSTYP does not support -o $mountopt"
> > > +	fi
> > > +
> > > +	# For new dax mount option, /proc/mounts shows "dax=never" if we
> > > +	# mount with -o dax on xfs and underlying device doesn't support dax.
> > > +	if [ "$mountopt" = "dax" ]; then
> > > +		echo $output | grep -qw "dax=never"&&  \
> > > +			_notrun "$SCRATCH_DEV $FSTYP does not support -o $mountopt"
> > > +	fi
> > > +
> > > +	_scratch_unmount
> > > +}
> > > +
> > > +_require_scratch_dax_iflag()
> > > +{
> > > +	_require_xfs_io_command "chattr" "x"
> > > +}
> > > +
> > >   # Does norecovery support by this fs?
> > >   _require_norecovery()
> > >   {
> > > --
> > > 2.21.0
> > > 
> > > 
> > > 
> > 
> > 
> > .
> > 
> 
> 
> 
