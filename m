Return-Path: <SRS0=eAkR=YH=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AC0ECE587
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Oct 2019 16:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B71320663
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Oct 2019 16:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o5ZNDeV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbfJNQlM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:41:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38442 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfJNQlM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Oct 2019 12:41:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EGOhkt185212;
        Mon, 14 Oct 2019 16:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=x4h2TXk0qaY84wiLThxLg2G4gdCdL0LYozyi9D4RkwQ=;
 b=o5ZNDeV2YnsjqmaoudYfjq99Zmu0Ns95GgobDEjkDviDbETWZaZi5kyqXwIcVlXQyVt+
 wmk8pdls8CKOVxpvznNSEm6TPH/RuNckxRP+6R9BsTxiUSlAUF+b02mOxGbAvDH9fDRp
 hnu8yJONxxkcrpai2fG7ERqieVnwaak+H+Ilxgl2tj3ubKDWbxu+vKiIxSfK7QZQdvSq
 u9zPz2/m5sVT3eIIUxJ/h4sslyYgJyc1Bvn8h9m8JVuymhXd92aFL53NpOWAFxid352r
 5//FSj/WZlxOiXwbJrns51dwgd4QRBOhMq+xf+Az7yRWleNOZF/hUsnz9Fhb90M7906c iQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vk6sqa5c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 16:41:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EGNZn4151017;
        Mon, 14 Oct 2019 16:39:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vkrbk6baj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 16:39:07 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9EGd6a0012344;
        Mon, 14 Oct 2019 16:39:06 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Oct 2019 16:39:05 +0000
Date:   Mon, 14 Oct 2019 09:39:04 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/097: Remove wrong broken assignment operation
Message-ID: <20191014163904.GF26541@magnolia>
References: <1570432515-13184-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191007151244.GC13097@magnolia>
 <56deacb8-1d4a-193c-f41c-469c78d97315@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56deacb8-1d4a-193c-f41c-469c78d97315@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910140142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910140142
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 08, 2019 at 10:39:59AM +0800, Yang Xu wrote:
> 
> 
> on 2019/10/07 23:12, Darrick J. Wong wrote:
> > On Mon, Oct 07, 2019 at 03:15:15PM +0800, Yang Xu wrote:
> > > On old kernel, since commit ded188b8609 ("xfs: Fix the situation that mount
> > > operation rejects corrupted XFS") running this case got the mismatched output,
> > > as below:
> > 
> > But why did the output mismatch?  Did the fs heal itself?  Did
> > allocating 5 more files somehow avoid touching the finobt?  Is the
> > assignment logic in the loop broken?
> 
> The output mismatch because on old kernel, we can mount the corrupted xfs
> and touch action will be refused. so broken is equal to 0.
> The fs doesn't heal ifself.
> allocating 5 more file will touch the finobt.
> 
> You can see this url
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=ded188b86096e2845e59dedae6050c7f254a96b
> 
> eg xfs/087, they all delete "broken=0" before allocationg 5 more file.
> commit ded188b86 compatibled old kernel(permit mount and refuse touch) and
> new kernel(refuse mount) behavior on corrupted xfs.  Or, I misunderstand
> this case?

How old is the kernel?  At some point (4.10, I think?) we added a patch
to reserve metadata blocks for future free inode btree expansion.  That
required us to count the blocks in the finobt, at which point xfs/097's
behavior changed such that the fs doesn't mount after the test corrupts
the finobt.

--D

> > 
> > --D
> > 
> > > -----------------------------------
> > >   + check fs
> > >   + corrupt image
> > >   + mount image && modify files
> > > -broken: 1
> > > +broken: 0
> > >   + repair fs
> > >   + mount image (2)
> > > ------------------------------------
> > > 
> > > It fails because the broken is always equal to 0 when _try_scratch_mount
> > > succeed. So remove this wrong assignment operation.
> > > 
> > > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> > > ---
> > >   tests/xfs/097 | 2 --
> > >   1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/tests/xfs/097 b/tests/xfs/097
> > > index 1cb7d69c..20791738 100755
> > > --- a/tests/xfs/097
> > > +++ b/tests/xfs/097
> > > @@ -81,8 +81,6 @@ done
> > >   echo "+ mount image && modify files"
> > >   broken=1
> > >   if _try_scratch_mount >> $seqres.full 2>&1; then
> > > -
> > > -	broken=0
> > >   	for x in `seq 65 70`; do
> > >   		touch "${TESTFILE}.${x}" 2> /dev/null && broken=0
> > >   	done
> > > -- 
> > > 2.18.1
> > > 
> > > 
> > > 
> > 
> > 
> 
> 
