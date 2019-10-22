Return-Path: <SRS0=glCd=YP=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7E5CA9EAF
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Oct 2019 01:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB03D2166E
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Oct 2019 01:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TIgVtTZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfJVB5i (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Oct 2019 21:57:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56858 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJVB5i (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Oct 2019 21:57:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9M1uhMa013663;
        Tue, 22 Oct 2019 01:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=MUCtMVFqGJOiowmrXK47eOPyzeHo90Y3DkrOHzmsdPM=;
 b=TIgVtTZMbsiecWXN8AGP1j97Enkp6P1rAD5bqzLFMd1hfhx7HTWHdeZKqh1wc02jDFtX
 P1JFgc9mhA4hhWEj1/YvUeKTMbFkwiAYs4nKJTQuEJzrqUf7AsXPFVCTRQOM9YDt6UJz
 1eGEaZUGV9gPKG3YmY4RF9yYWboH/q+R8+0fqd6MEqDEZRnRPSzGZfUkMhQpdJNoKoeP
 Ao9jeh1GEQWL8UsfWmpwaVGPgVreB+hMvajimk48jhJixUsny8uSe8ds15PR1mkIQedp
 8dN3DJYZKZs7vUzpHW2VXzzeceej15AT75U1rw9qI+1do1tgQryq5lbJlVkEpd+auHT0 Sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vqu4qk6pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 01:57:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9M1rA8n075784;
        Tue, 22 Oct 2019 01:55:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vsakcejxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 01:55:31 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9M1tTjA005444;
        Tue, 22 Oct 2019 01:55:29 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 18:55:29 -0700
Date:   Mon, 21 Oct 2019 18:55:28 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     guaneryu@gmail.com, fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/097: Remove wrong broken assignment operation
Message-ID: <20191022015528.GD6726@magnolia>
References: <1570432515-13184-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191007151244.GC13097@magnolia>
 <56deacb8-1d4a-193c-f41c-469c78d97315@cn.fujitsu.com>
 <20191014163904.GF26541@magnolia>
 <0925e033-0d0d-6eb4-8b1b-ca980ee5cd20@cn.fujitsu.com>
 <74874fd4-6034-d5c0-4f9d-5f0de5ef9703@cn.fujitsu.com>
 <20191021155039.GB6726@magnolia>
 <f9f2f492-d59d-c45d-8d48-232adefebe85@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9f2f492-d59d-c45d-8d48-232adefebe85@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910220017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910220017
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 22, 2019 at 09:49:48AM +0800, Yang Xu wrote:
> 
> 
> on 2019/10/21 23:50, Darrick J. Wong wrote:
> > On Mon, Oct 21, 2019 at 08:09:39PM +0800, Yang Xu wrote:
> > > 
> > > 
> > >   on 2019/10/15 14:27, Yang Xu wrote:
> > > > 
> > > > 
> > > > on 2019/10/15 0:39, Darrick J. Wong wrote:
> > > > > On Tue, Oct 08, 2019 at 10:39:59AM +0800, Yang Xu wrote:
> > > > > > 
> > > > > > 
> > > > > > on 2019/10/07 23:12, Darrick J. Wong wrote:
> > > > > > > On Mon, Oct 07, 2019 at 03:15:15PM +0800, Yang Xu wrote:
> > > > > > > > On old kernel, since commit ded188b8609 ("xfs: Fix the
> > > > > > > > situation that mount
> > > > > > > > operation rejects corrupted XFS") running this case got
> > > > > > > > the mismatched output,
> > > > > > > > as below:
> > > > > > > 
> > > > > > > But why did the output mismatch?  Did the fs heal itself?  Did
> > > > > > > allocating 5 more files somehow avoid touching the finobt?  Is the
> > > > > > > assignment logic in the loop broken?
> > > > > > 
> > > > > > The output mismatch because on old kernel, we can mount the
> > > > > > corrupted xfs
> > > > > > and touch action will be refused. so broken is equal to 0.
> > > > > > The fs doesn't heal ifself.
> > > > > > allocating 5 more file will touch the finobt.
> > > > > > 
> > > > > > You can see this url
> > > > > > https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=ded188b86096e2845e59dedae6050c7f254a96b
> > > > > > 
> > > > > > 
> > > > > > eg xfs/087, they all delete "broken=0" before allocationg 5 more file.
> > > > > > commit ded188b86 compatibled old kernel(permit mount and refuse
> > > > > > touch) and
> > > > > > new kernel(refuse mount) behavior on corrupted xfs.  Or, I misunderstand
> > > > > > this case?
> > > > > 
> > > > > How old is the kernel?  At some point (4.10, I think?) we added a patch
> > > > > to reserve metadata blocks for future free inode btree expansion.  That
> > > > > required us to count the blocks in the finobt, at which point xfs/097's
> > > > > behavior changed such that the fs doesn't mount after the test corrupts
> > > > > the finobt.
> > > > I test this case on kernel-3.10.0-1062.el7.x86_64.
> > > > I find the patch you said to reserve metadata blocks for future free
> > > > inode btree expansion. This kernel doesn't backport this commit 76d771b4
> > > > ("xfs: use per-AG reservations for the finobt"), so it permmits to
> > > > mount.
> > > > 
> > > > I can understand your meaning. But from xfstests commit ded188b86, it
> > > > looks like refuse touch or refuse mount is acceptable for xfstests.
> > > > 
> > > > Also, xfs/087 is a similar case but it sets broken=1 instead of broken
> > > > =0.  Before this kernel commit 76d771b4, xfs/087(xfs/097) permits mount
> > > > and refuse touch, after this commit, xfs/087(xfs/097) refuses mount.
> > > > I think we should keep xfs/097 consistent with xfs/087. What do you
> > > > think about it?
> > > > 
> > > > ps:my patch is intend to fix the inconsistent of broken assignment
> > > > operation that xfstests commit ded188b86 introduced.
> > > Hi Darrick
> > >    Do you have some questions on this patch?
> > 
> > Does it still pass on upstreeam 5.4?
> 
> Of course. It still can pass on upstream 5.4.
> 
> --------------------------------------
> echo "+ mount image && modify files"
> broken=1
> //on kernel with commit d771b4 ("xfs: use per-AG reservations for the
> //finobt", it will not run into this if judgement, so broken=1.
> //on kernel without this kernel commit, it will run into this if //judgement
> and touch will be refused, so broken is still equal to 1.
> if _try_scratch_mount >> $seqres.full 2>&1; then
>         for x in `seq 65 70`; do
>                 touch "${TESTFILE}.${x}" 2> /dev/null && broken=0
>         done
>         umount "${SCRATCH_MNT}"
> fi
> --------------------------------------

Ah, ok.  Looks good to me then.  Sorry I was a little slow on the
uptake. :/

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> > 
> > --D
> > 
> > > Hi Eryu
> > >     What do you think about this patch(I only want to keep xfs/097 consistent
> > > with xfs/087).
> > > > 
> > > > Thanks
> > > > Yang Xu
> > > > 
> > > > > 
> > > > > --D
> > > > > 
> > > > > > > 
> > > > > > > --D
> > > > > > > 
> > > > > > > > -----------------------------------
> > > > > > > >     + check fs
> > > > > > > >     + corrupt image
> > > > > > > >     + mount image && modify files
> > > > > > > > -broken: 1
> > > > > > > > +broken: 0
> > > > > > > >     + repair fs
> > > > > > > >     + mount image (2)
> > > > > > > > ------------------------------------
> > > > > > > > 
> > > > > > > > It fails because the broken is always equal to 0 when
> > > > > > > > _try_scratch_mount
> > > > > > > > succeed. So remove this wrong assignment operation.
> > > > > > > > 
> > > > > > > > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> > > > > > > > ---
> > > > > > > >     tests/xfs/097 | 2 --
> > > > > > > >     1 file changed, 2 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/tests/xfs/097 b/tests/xfs/097
> > > > > > > > index 1cb7d69c..20791738 100755
> > > > > > > > --- a/tests/xfs/097
> > > > > > > > +++ b/tests/xfs/097
> > > > > > > > @@ -81,8 +81,6 @@ done
> > > > > > > >     echo "+ mount image && modify files"
> > > > > > > >     broken=1
> > > > > > > >     if _try_scratch_mount >> $seqres.full 2>&1; then
> > > > > > > > -
> > > > > > > > -    broken=0
> > > > > > > >         for x in `seq 65 70`; do
> > > > > > > >             touch "${TESTFILE}.${x}" 2> /dev/null && broken=0
> > > > > > > >         done
> > > > > > > > -- 
> > > > > > > > 2.18.1
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > > 
> > > > > 
> > > > > 
> > > > 
> > > > 
> > > 
> > > 
> > 
> > 
> 
> 
