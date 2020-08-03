Return-Path: <SRS0=C+DF=BN=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0529BC433DF
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Aug 2020 22:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16FF920722
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Aug 2020 22:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NXa173ji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHCW04 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:26:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32900 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCW04 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Aug 2020 18:26:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073MMpST081511;
        Mon, 3 Aug 2020 22:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=5RcT85Q2U0TBZIaTYqZcYwodp3mdGEfR3cOTlOD9w6I=;
 b=NXa173jiIdFT7DGOpJ11E/njZwy8v9ckkuXF7PPJ+JML2WmeKN/QO2rg0kZ5EYan0kRr
 GH8GB+vBL8e0IsW8+kY8ao9idK4TuyOFyAoy/HFt9P1v0vedja9aB+i6/ENkO7DHDUSh
 ZLFNlbOLWwKIeEdBOIEYCNzisKXNAtrE7T8ImQtK6s0HlDRy933szYY3hEpuMFARElUq
 J5LsTAZRkc8cmWhe8ZXHt5Um/XtriWNK9qAEGo4buduJNRE/l1FXDMv+gh5+c7ZPLydL
 jzwk0edok9b7/eiMcoRQMsNNnjuqcbZVVi8nMerc31bIl/yDgYNV9+SpyKkDRd0+CZk8 kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32n11n11rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 22:26:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073MNgHa092662;
        Mon, 3 Aug 2020 22:26:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32njavk84k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 22:26:48 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 073MQmbE023977;
        Mon, 3 Aug 2020 22:26:48 GMT
Received: from localhost (/10.159.237.68)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Aug 2020 15:26:47 -0700
Date:   Mon, 3 Aug 2020 15:26:45 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Xiao Yang <yangx.jy@cn.fujitsu.com>, guaneryu@gmail.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH v8 1/7] common/rc: Introduce helpers for new dax mount
 options and FS_XFLAG_DAX
Message-ID: <20200803222645.GB1203354@magnolia>
References: <20200803083838.26222-1-yangx.jy@cn.fujitsu.com>
 <20200803083838.26222-2-yangx.jy@cn.fujitsu.com>
 <20200803194915.GF1573827@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803194915.GF1573827@iweiny-DESK2.sc.intel.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=1 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030153
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 03, 2020 at 12:49:19PM -0700, Ira Weiny wrote:
> On Mon, Aug 03, 2020 at 04:38:32PM +0800, Xiao Yang wrote:
> > 1) _check_scratch_dax_mountopt() checks old/new dax mount option and
> >    returns a value.
> > 2) _require_scratch_dax_mountopt() throws notrun if _check_scratch_dax_mountopt()
> >    returns a non-zero value.
> > 3) _require_dax_iflag() checks FS_XFLAG_DAX.
> > 
> > Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> > ---
> >  common/rc | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 1b7b2575..d7926bc5 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3188,6 +3188,48 @@ _require_scratch_dax()
> >  	_scratch_unmount
> >  }
> >  
> > +# Only accept dax/dax=always mount option becasue dax=always, dax=inode
> > +# and dax=never are always introduced together.
> > +# Return 0 if filesystem/device supports the specified dax option.
> > +# Return 1 if mount fails with the specified dax option.
> > +# Return 2 if /proc/mounts shows wrong dax option.
> > +# Check new dax=inode, dax=always or dax=never option by passing "dax=always".
> > +# Check old dax or new dax=always by passing "dax".
> > +_check_scratch_dax_mountopt()
> 
> So I think I see what you are trying to say here but I'm not sure the
> comment/doc is clear.  How about:
> 
> # Check if dax mount options are supported
> #
> # $1 can be either 'dax=always' or 'dax'
> #
> # dax=always
> #      Check for the new dax options (dax=inode, dax=always or dax=never) by
> #      passing "dax=always".
> # dax
> #      Check for the old dax or new dax=always by passing "dax".
> #
> # This only accepts 'dax=always' because dax=always, dax=inode
> # and dax=never are always supported together.  So if the other options are
> # required checking for 'dax=always' indicates support for the other 2.
> #
> # Return 0 if filesystem/device supports the specified dax option.
> # Return 1 if mount fails with the specified dax option.
> # Return 2 if /proc/mounts shows wrong dax option.

/me likes this better.

--D

> Ira
> 
> > +{
> > +	local option=$1
> > +
> > +	_require_scratch
> > +	_scratch_mkfs > /dev/null 2>&1
> > +
> > +	_try_scratch_mount "-o $option" > /dev/null 2>&1 || return 1
> > +
> > +	if _fs_options $SCRATCH_DEV | egrep -q "dax(=always|,|$)"; then
> > +		_scratch_unmount
> > +		return 0
> > +	else
> > +		_scratch_unmount
> > +		return 2
> > +	fi
> > +}
> > +
> > +# Throw notrun if _check_scratch_dax_mountopt() returns a non-zero value.
> > +_require_scratch_dax_mountopt()
> > +{
> > +	local mountopt=$1
> > +
> > +	_check_scratch_dax_mountopt "$mountopt"
> > +	local res=$?
> > +
> > +	[ $res -eq 1 ] && _notrun "mount $SCRATCH_DEV with $mountopt failed"
> > +	[ $res -eq 2 ] && _notrun "$SCRATCH_DEV $FSTYP does not support -o $mountopt"
> > +}
> > +
> > +_require_dax_iflag()
> > +{
> > +	_require_xfs_io_command "chattr" "x"
> > +}
> > +
> >  # Does norecovery support by this fs?
> >  _require_norecovery()
> >  {
> > -- 
> > 2.21.0
> > 
> > 
> > 
