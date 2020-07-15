Return-Path: <SRS0=5/bx=A2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB762C433E5
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 16:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC69820672
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 16:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qiL7WoHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgGOQtZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:49:25 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34874 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgGOQtZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Jul 2020 12:49:25 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FFm6Ac134245;
        Wed, 15 Jul 2020 16:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=rWqi915mYocjmpsemrOozK71vMsYI8udvX5rW9BfI5Y=;
 b=qiL7WoHinUDHehYpX6mYW4LjH/w4nmpauj4ztefJBc2RcQMQvFHMdF/OMMYmhTY3VA+D
 va2As1WmwGarflj82sPPz8Kw8l00tgyJSS8yDgslojPYaNIxn2JvNIznSePcGkcVWYLj
 RGDw+2cOLy1f/r0AVoZYvV5aa0BWfdyMe5PfGQxZJ4WVk97VUV9uMrB2RaBqn6SLYzKz
 N3yeKfaJUzwxlBuNDk3ZSSy7ldU2+I2qAyPo8DlPX7AiN/pOaEL0Sh+6ljwPPPDJW4Ef
 ydijfe14rFlnqyCHvxoPSkdGfxnaxn2hq5e2OZM39l19mV+IzfocK1+Q/nZvwa276J1l xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 327s65jm29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Jul 2020 16:07:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FFlpAO114490;
        Wed, 15 Jul 2020 16:07:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 32a4cqtcsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 16:07:31 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06FG7UjZ013713;
        Wed, 15 Jul 2020 16:07:30 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jul 2020 09:07:30 -0700
Date:   Wed, 15 Jul 2020 09:07:29 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, fstests@vger.kernel.org
Subject: Re: [PATCH v6 3/7] generic/223: Don't clear all mkfs options for
 _scratch_mkfs_geom() roughly
Message-ID: <20200715160729.GM7600@magnolia>
References: <20200714094009.8654-1-yangx.jy@cn.fujitsu.com>
 <20200714094009.8654-4-yangx.jy@cn.fujitsu.com>
 <20200715023117.GH3008823@iweiny-DESK2.sc.intel.com>
 <5F0E7424.2090709@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F0E7424.2090709@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 suspectscore=1 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
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

On Wed, Jul 15, 2020 at 11:12:36AM +0800, Xiao Yang wrote:
> On 2020/7/15 10:31, Ira Weiny wrote:
> > On Tue, Jul 14, 2020 at 05:40:05PM +0800, Xiao Yang wrote:
> > > ext4 can accept the last one if the same mkfs options are passed but xfs cannot
> > I'm having trouble parsing this commit message.  What does 'last one' refer to?
> > 
> > > accept the same mkfs options and reports "xxx option is respecified" error.
> > Ok I think I understand now.  Some FS's (XFS) do not accept an option more than
> > once.  So we can't just blindly add options to the end of the MKFS_OPTIONS.  Is
> > that correct?
> Hi Ira,
> 
> Correct.
> > > I
> > > prefer to override the same mkfs option which is defined in MKFS_OPTION so that
> > > we can have a chance to pass other mkfs options to _scratch_mkfs_geom().
> > Instead the patch parses the current option string and replaces the value if
> > the option is already there.  This allows us to specify MKFS_OPTIONS to
> > generic/223.
> Right. :-)
> 
> XFS_MKFS_OPTIONS/MKFS_OPTIONS can be used to specify some custom options by user,
> so I don't want to clear it blindly.
>
> Thanks,
> Xiao Yang
> > I think the code is reasonable although my sed skills are not good enough to
> > tell for sure...  ;-)
> > 
> > Ira
> > 
> > > Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> > > ---
> > >   common/rc         | 14 +++++++++++++-
> > >   tests/generic/223 |  1 -
> > >   2 files changed, 13 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 6c908f2e..567cf83b 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -1051,7 +1051,19 @@ _scratch_mkfs_geom()
> > > 
> > >       case $FSTYP in
> > >       xfs)
> > > -	MKFS_OPTIONS+=" -b size=$blocksize, -d su=$sunit_bytes,sw=$swidth_mult"
> > > +	if echo "$MKFS_OPTIONS" | egrep -q "b?size="; then
> > > +		MKFS_OPTIONS=$(echo "$MKFS_OPTIONS" | sed -r "s/(b?size=)[0-9]+/\1$blocksize/")
> > > +	else
> > > +		MKFS_OPTIONS+=" -b size=$blocksize"
> > > +	fi
> > > +
> > > +	if echo "$MKFS_OPTIONS" | egrep -q "(su|sunit|sw|swidth)="; then
> > > +		MKFS_OPTIONS=$(echo "$MKFS_OPTIONS" | sed -r \
> > > +			-e "s/(su|sunit)=[0-9kmg]+/su=$sunit_bytes/" \
> > > +			-e "s/(sw|swidth)=[0-9kmg]+/sw=$swidth_mult/")
> > > +	else
> > > +		MKFS_OPTIONS+=" -d su=$sunit_bytes,sw=$swidth_mult"
> > > +	fi

...ok, I see, this makes the function smart enough to substitute
geometry parameters instead of dumping them on the end and letting that
blow up.  Heh, ok, that's definitely a weird quirk I've noticed.

> > >   	;;
> > >       ext4|ext4dev)
> > >   	MKFS_OPTIONS+=" -b $blocksize -E stride=$sunit_blocks,stripe_width=$swidth_blocks"
> > > diff --git a/tests/generic/223 b/tests/generic/223
> > > index 6cfd00dd..ba7c9a44 100755
> > > --- a/tests/generic/223
> > > +++ b/tests/generic/223
> > > @@ -41,7 +41,6 @@ for SUNIT_K in 8 16 32 64 128; do
> > >   	let SUNIT_BLOCKS=$SUNIT_BYTES/$BLOCKSIZE
> > > 
> > >   	echo "=== mkfs with su $SUNIT_BLOCKS blocks x 4 ==="
> > > -	export MKFS_OPTIONS=""

So I guess you're deleting this so that the test runs with whatever
MKFS_OPTIONS the test runner specified, while letting the test edit
blocksize and stripe parameters?

Proving I'm still bad at remembering to read commit messages,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> > >   	_scratch_mkfs_geom $SUNIT_BYTES 4 $BLOCKSIZE>>  $seqres.full 2>&1
> > >   	_scratch_mount
> > > 
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
