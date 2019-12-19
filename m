Return-Path: <SRS0=0bps=2J=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B027AC43603
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Dec 2019 17:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2922053B
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Dec 2019 17:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p2HL4+yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLSRJJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:09:09 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51402 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfLSRJJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Dec 2019 12:09:09 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJGEK4w143745;
        Thu, 19 Dec 2019 17:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=1WOUHMD/s4pu7LkEPZupQpKRpCxM8b1n6XEFJSspbeY=;
 b=p2HL4+yyhJkQNoegz3E9rGtIUvMRPvctOJWfNM2cipxZY/JFv5yVC9KeICykAt3wS/+B
 UjNvkCzntqKheVnMgF/hIhZmnMfDIywyJ57AVZdRi/buOljvrAQELAIh5uDqrZsi8M2r
 Yip6b8h1+MVA1Pi2dM9bKpiLS8WToocSSJJv62QZA4ejjtGM8k3QG4O371JcmOpylFzx
 q5fZkjbSKgcObofy0jFLINNj1fce5GLIbyxQay8e0AItUau9qChki/HNFuIefVCC7cX8
 xuGQRNyAH8t7V/c3ilFGcr0fRCspaqldmVtF3Z5tobB8gsoBVg9juEVCytLclWFnJ3by +A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2x01jac5es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 17:09:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJGES36136853;
        Thu, 19 Dec 2019 17:09:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wyut5mrbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 17:09:01 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBJH91Qn011137;
        Thu, 19 Dec 2019 17:09:01 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 09:09:00 -0800
Date:   Thu, 19 Dec 2019 09:08:59 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/520: use fsync instead of sync during clean_dir
Message-ID: <20191219170859.GE7497@magnolia>
References: <1576215941-19208-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191213204241.GC99869@magnolia>
 <8899c91c-1f92-4f49-c994-f04c9a6eb5fd@cn.fujitsu.com>
 <20191217223619.GI12766@magnolia>
 <3dffc06e-fceb-e7a5-b739-afd15f6b4093@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dffc06e-fceb-e7a5-b739-afd15f6b4093@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190135
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Dec 18, 2019 at 10:37:51AM +0800, Yang Xu wrote:
> 
> 
> on 2019/12/18 6:36, Darrick J. Wong wrote:
> > On Mon, Dec 16, 2019 at 02:24:56PM +0800, Yang Xu wrote:
> > > 
> > > 
> > > on 2019/12/14 4:42, Darrick J. Wong wrote:
> > > > On Fri, Dec 13, 2019 at 01:45:41PM +0800, Yang Xu wrote:
> > > > > When I test this case on xfs, it may fail as below:
> > > > > --------------------------------------------
> > > > >    === link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT/A ===
> > > > > +umount: /mnt/xfstests/scratch: target is busy.
> > > > > +        (In some cases useful info about processes that use
> > > > > +         the device is found by lsof(8) or fuser(1))
> > > > > ---------------------------------------------
> > > > > 
> > > > > I think we don't need to sync all fs and fsync SCRATCH_MNT is enough.
> > > > > 
> > > > > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> > > > > ---
> > > > >    tests/generic/520 | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/tests/generic/520 b/tests/generic/520
> > > > > index 167d7077..a16467ca 100755
> > > > > --- a/tests/generic/520
> > > > > +++ b/tests/generic/520
> > > > > @@ -58,7 +58,7 @@ clean_dir()
> > > > >    {
> > > > >    	_mount_flakey
> > > > >    	rm -rf $(find $SCRATCH_MNT/* | grep -v "lost+found")
> > > > > -	sync
> > > > > +	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT
> > > > 
> > > > But that only has to force the scratch mount directory to disk.
> > > > 
> > > > Assuming the test authors really meant "write all of the scratch fs'
> > > > dirty data/metadata to disk", I think you want:
> > > > 
> > > >    $XFS_IO_PROG -c syncfs $SCRATCH_MNT
> > > > 
> > > > here?
> > > My xfsprogs version doesn't support syncfs command. Or, we can use fsync to
> > > make four files(foo bar A/foo A/bar) write to disk?
> > 
> > Hmm, 'sync -f $SCRATCH_MNT' then?
> Both syncfs and sync -f are all useful when I test on 4.18.0-147.el8.x86_64.
> But on old system (3.10.0-1101.el7.x86_64
> ), sync command doesn't support -f option.  Or, I think we should use a
> generic way to avoid busy error. IMHO, it has two ways(mkfs and fsync), but
> mkfs will add more test time. What do you think about it?

Ahh, ok.  I guess fsyncing the four things is fine then.

> > > > Also, why did umount spit out 'target is busy' here?  clean_dir() erases
> > > > the scratch fs between tests, there shouldn't be anything flakey about
> > > > that.
> > > I try to find the cause of this but fail. I debug it but no useful
> > > output(using  _unmount_flakey  || fuser -uvm $SCRATCH_MNT ), failed as
> > > below:
> > > umount: /mnt/xfstests/scratch: target is busy.
> > >          (In some cases useful info about processes that use
> > >           the device is found by lsof(8) or fuser(1))
> > >                       USER        PID ACCESS COMMAND
> > > /mnt/xfstests/scratch:
> > >                       root     kernel mount (root)/mnt/xfstests/scratch
> > > 
> > > ps: My test machine only excutes this cases and doesn't do other  things.
> > 
> > Does a second umount attempt succeed after the fuser fails to find
> > anything sitting on the mount?
> Yes, second umount succeed.

Also, which kernel behaves like this?  Does it happen with upstream?
AFAICT when running this in a loop on 5.5-rc2 it doesn't exhibit this
failure, but maybe another kernel does?

--D

> > --D
> > 
> > > > 
> > > > --D
> > > > 
> > > > >    	_unmount_flakey
> > > > >    }
> > > > > -- 
> > > > > 2.18.0
> > > > > 
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
