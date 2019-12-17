Return-Path: <SRS0=EflN=2H=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28180C43603
	for <linux-fstests@archiver.kernel.org>; Tue, 17 Dec 2019 22:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED11424650
	for <linux-fstests@archiver.kernel.org>; Tue, 17 Dec 2019 22:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xft+fwAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfLQWg2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 Dec 2019 17:36:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35376 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfLQWg2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 Dec 2019 17:36:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBHMYNdG111580;
        Tue, 17 Dec 2019 22:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=tv+lq0cqi3TWcOC5PQIJ3zLfD6tp7B2FTcgBRMcjW1g=;
 b=Xft+fwAf2YG81u/hIIsleCAGMrBgV/dx419c7fifWfpf91zPu6Kv/LS0cwxyrMuTrRqK
 1Ol7pXPKjjYrsgFb0XkvzTg7cETNmywSE8zFj2nCrPkzC4s6phIyTf5167MpJIVhNE3S
 XTLqpfXL0I4kiDKyD/e4OwpWXvZVFC17cru4jyCmt/QCbzFHhsbSZBDdKCHlwx0Tm+D5
 dwUm8heHF56Dbq/7B3Mi+KwWsqg88THM9FgPnLgUjwkDz0onqvWtNxgSOjOv63vfp+k+
 mBL1WXeCoW1OIcNwij0qA66C2hhd/1kyRM99DVezoHXi3l2m/YtPerGYZkF+hxYB4l+Z 6A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wvq5uhv5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 22:36:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBHMYHnB018508;
        Tue, 17 Dec 2019 22:36:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wxm5krn82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 22:36:23 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBHMaL3l031894;
        Tue, 17 Dec 2019 22:36:21 GMT
Received: from localhost (/10.159.137.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Dec 2019 14:36:20 -0800
Date:   Tue, 17 Dec 2019 14:36:19 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/520: use fsync instead of sync during clean_dir
Message-ID: <20191217223619.GI12766@magnolia>
References: <1576215941-19208-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191213204241.GC99869@magnolia>
 <8899c91c-1f92-4f49-c994-f04c9a6eb5fd@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8899c91c-1f92-4f49-c994-f04c9a6eb5fd@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912170180
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912170180
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Dec 16, 2019 at 02:24:56PM +0800, Yang Xu wrote:
> 
> 
> on 2019/12/14 4:42, Darrick J. Wong wrote:
> > On Fri, Dec 13, 2019 at 01:45:41PM +0800, Yang Xu wrote:
> > > When I test this case on xfs, it may fail as below:
> > > --------------------------------------------
> > >   === link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT/A ===
> > > +umount: /mnt/xfstests/scratch: target is busy.
> > > +        (In some cases useful info about processes that use
> > > +         the device is found by lsof(8) or fuser(1))
> > > ---------------------------------------------
> > > 
> > > I think we don't need to sync all fs and fsync SCRATCH_MNT is enough.
> > > 
> > > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> > > ---
> > >   tests/generic/520 | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/generic/520 b/tests/generic/520
> > > index 167d7077..a16467ca 100755
> > > --- a/tests/generic/520
> > > +++ b/tests/generic/520
> > > @@ -58,7 +58,7 @@ clean_dir()
> > >   {
> > >   	_mount_flakey
> > >   	rm -rf $(find $SCRATCH_MNT/* | grep -v "lost+found")
> > > -	sync
> > > +	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT
> > 
> > But that only has to force the scratch mount directory to disk.
> > 
> > Assuming the test authors really meant "write all of the scratch fs'
> > dirty data/metadata to disk", I think you want:
> > 
> >   $XFS_IO_PROG -c syncfs $SCRATCH_MNT
> > 
> > here?
> My xfsprogs version doesn't support syncfs command. Or, we can use fsync to
> make four files(foo bar A/foo A/bar) write to disk?

Hmm, 'sync -f $SCRATCH_MNT' then?

> > Also, why did umount spit out 'target is busy' here?  clean_dir() erases
> > the scratch fs between tests, there shouldn't be anything flakey about
> > that.
> I try to find the cause of this but fail. I debug it but no useful
> output(using  _unmount_flakey  || fuser -uvm $SCRATCH_MNT ), failed as
> below:
> umount: /mnt/xfstests/scratch: target is busy.
>         (In some cases useful info about processes that use
>          the device is found by lsof(8) or fuser(1))
>                      USER        PID ACCESS COMMAND
> /mnt/xfstests/scratch:
>                      root     kernel mount (root)/mnt/xfstests/scratch
> 
> ps: My test machine only excutes this cases and doesn't do other  things.

Does a second umount attempt succeed after the fuser fails to find
anything sitting on the mount?

--D

> > 
> > --D
> > 
> > >   	_unmount_flakey
> > >   }
> > > -- 
> > > 2.18.0
> > > 
> > > 
> > > 
> > 
> > 
> 
> 
