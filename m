Return-Path: <SRS0=d97O=BI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E48C433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 14:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798C4206D8
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 14:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O1Nx0Pkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgG2Ouj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:50:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41834 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2Ouj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jul 2020 10:50:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TEff6q146089;
        Wed, 29 Jul 2020 14:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=bf14ieXiNQQQh0hdHmB3YyfFNr2ksABxcMYU1JDI/bM=;
 b=O1Nx0PkkSBoQp44qoPPPkOKJ0DUZecXyuahNUX1DjPb9KKLXRz2WnOc8Wv91dqVx2aYt
 +ILgFDvjLrAT8HiR7DpgrAoEMQfuEpwy14rtwkXn/lda18cj/NC9ic7VxtMva47FThmM
 /mmz5/ZMcHmrvXTI9RecbFMlFHZiStqY4pJNhhf3rj8djuWS3dpG2OMWS3GlND5MPWbR
 6n9ZaV5PVVI6wv8DXpgyxK6kW64TIvBUF77DcjuHv00MdvyZ1q0hIMho6MM6drj0juEk
 DEGD1jkk2d6XIRdXkCPurWKdetpmuW6VCqjMGe4Fe8FEiqW9BgIvXDfrGM+iQR2Za9xN 1Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32hu1jp31j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 14:50:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TEmrhI166600;
        Wed, 29 Jul 2020 14:50:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 32hu5vv8ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 14:50:35 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06TEoYmV018379;
        Wed, 29 Jul 2020 14:50:34 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 07:50:33 -0700
Date:   Wed, 29 Jul 2020 07:50:33 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] xfs/010,030: filter AG header CRC error warnings
Message-ID: <20200729145033.GY7600@magnolia>
References: <20200729025119.GV7600@magnolia>
 <20200729044956.GG2937@dhcp-12-102.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729044956.GG2937@dhcp-12-102.nay.redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=1 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290100
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 29, 2020 at 12:49:56PM +0800, Zorro Lang wrote:
> On Tue, Jul 28, 2020 at 07:51:19PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > Filter out the new AG header CRC verification warnings in xfs_repair
> > since these tests were built before that existed.
> > 
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> 
> Hi Darrick,
> 
> I still hit an error[1] on xfs/030 after merge your patch.

D'oh, I forgot to send that one out in this batch.  Will fix that
shortly.

--D

> Thanks,
> Zorro
> 
> # diff -u ./tests/xfs/030.out ./results//xfs/030.out.bad                                                          
> --- /root/git/xfstests-dev/tests/xfs/030.out    2020-03-12 11:22:50.063148796 +0800
> +++ /root/git/xfstests-dev/results//xfs/030.out.bad     2020-07-29 12:33:08.485428533 +0800
> @@ -105,6 +105,7 @@
>  Phase 2 - using <TYPEOF> log
>          - zero log...
>          - scan filesystem freespace and inode maps...
> +bad agbno AGBNO in agfl, agno 0
>          - found root inode chunk
>  Phase 3 - for each AG...
>          - scan and clear agi unlinked lists...
> 
> >  tests/xfs/010 |    7 ++++++-
> >  tests/xfs/030 |    2 ++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/xfs/010 b/tests/xfs/010
> > index e220a651..b65dd3ba 100755
> > --- a/tests/xfs/010
> > +++ b/tests/xfs/010
> > @@ -113,7 +113,12 @@ _check_scratch_fs
> >  # nuke the finobt root, repair will have to regenerate from the inobt
> >  _corrupt_finobt_root $SCRATCH_DEV
> >  
> > -_scratch_xfs_repair 2>&1 | _filter_repair_lostblocks
> > +filter_finobt_repair() {
> > +	sed -e '/^agi has bad CRC/d' | \
> > +		_filter_repair_lostblocks
> > +}
> > +
> > +_scratch_xfs_repair 2>&1 | filter_finobt_repair
> >  
> >  status=0
> >  exit
> > diff --git a/tests/xfs/030 b/tests/xfs/030
> > index efdb6a18..ebe4c92a 100755
> > --- a/tests/xfs/030
> > +++ b/tests/xfs/030
> > @@ -42,6 +42,8 @@ _check_ag()
> >  			    -e '/^bad agbno AGBNO for finobt/d' \
> >  			    -e '/^bad agbno AGBNO for rmapbt/d' \
> >  			    -e '/^bad agbno AGBNO for refcntbt/d' \
> > +			    -e '/^agf has bad CRC/d' \
> > +			    -e '/^agi has bad CRC/d' \
> >  			    -e '/^Missing reverse-mapping record.*/d' \
> >  			    -e '/^unknown block state, ag AGNO, block.*/d'
> >  	done
> > 
> 
