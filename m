Return-Path: <SRS0=clGf=3F=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2734AC33CB6
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jan 2020 15:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D812073A
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jan 2020 15:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JVJAJfCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgAPPwk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:52:40 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33168 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPPwk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Jan 2020 10:52:40 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GFmK13089329;
        Thu, 16 Jan 2020 15:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=LNGVmmLm43bgoEmTzCRUrrPsP67oU1WdZ4VlCztZ1bI=;
 b=JVJAJfCR/mFI1YcehQCn0o1Rbo7KNmGCcRXsiLEeCr0aROU1tdyIiaPxjU05K3g0BGfv
 v27L5Jp80/o72HLoO4jtAWDpnYYiW6eDI+InYpCdhR4YV/1jgloL4UiBQvExy4uUeGbO
 27dUTht+hBN4v8ha+n1/phXmjelNKVk1xLqPAFh0RbdTxBbiGjaSGI4Rxtbt01sj7QJV
 eS2nhUrJdFceisiaSjzJ/+fLhpXyL7G/y2I2GB7euzEcSkBwOnExfkbqR3Bo7s03GLdO
 LcCYzhoWUlPJVtbp/pF1PymP6PlHh9ApqzVlfY7MrTd5V9hGkwyqeGelOzfQZyFvF8FS NA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xf73u398w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 15:52:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GFn5Pg120444;
        Thu, 16 Jan 2020 15:52:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xj61mtcbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 15:52:36 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00GFqZHb028892;
        Thu, 16 Jan 2020 15:52:35 GMT
Received: from localhost (/10.159.133.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jan 2020 07:52:35 -0800
Date:   Thu, 16 Jan 2020 07:52:33 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/175, generic/176: cleanup testdir before exit
Message-ID: <20200116155233.GB2149943@magnolia>
References: <20200113032409.11501-1-jencce.kernel@gmail.com>
 <20200113224203.GA8241@magnolia>
 <20200115042132.xl6ijsavac23x7dx@xzhoux.usersys.redhat.com>
 <20200115171923.GG8257@magnolia>
 <20200116074509.gnfkvvpy2jhahv3n@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116074509.gnfkvvpy2jhahv3n@xzhoux.usersys.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001160131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160131
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 16, 2020 at 03:45:09PM +0800, Murphy Zhou wrote:
> On Wed, Jan 15, 2020 at 09:19:23AM -0800, Darrick J. Wong wrote:
> > On Wed, Jan 15, 2020 at 12:21:32PM +0800, Murphy Zhou wrote:
> > > On Mon, Jan 13, 2020 at 02:42:03PM -0800, Darrick J. Wong wrote:
> > > > On Mon, Jan 13, 2020 at 11:24:09AM +0800, Murphy Zhou wrote:
> > > > > Usually the _mkfs helper will cleanup these directories at the
> > > > > beginning of testcase. However, when testing on NFS, the cleanup
> > > > > could be very slow and it is confusing that: We have already
> > > > > started to run generic/176 but we get stuck in _mkfs, cleaning
> > > > > up files left by the previous testcase generic/175.
> > > > 
> > > > Isn't this a general problem with the way nfs handles "mkfs" on scratch
> > > > devices?  So you'd want to fix this once by doing the cleanup between
> > > > tests instead of playing whackamole with whatever crazy file tests we
> > > > think of next?
> > > 
> > > Hmm, it's hard to tell. Deleting these files at anywhere makes sense.
> > > This patch is hardly a "fix", just trying to make it more clear.
> > > 
> > > > 
> > > > > To be clear, cleanup testdir before exit.
> > > > > 
> > > > > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > > > > ---
> > > > >  tests/generic/175 | 1 +
> > > > >  tests/generic/176 | 1 +
> > > > >  2 files changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/tests/generic/175 b/tests/generic/175
> > > > > index 79e5b3d6..bd966a28 100755
> > > > > --- a/tests/generic/175
> > > > > +++ b/tests/generic/175
> > > > > @@ -61,6 +61,7 @@ bytes=$((blks * blksz))
> > > > >  echo "reflinking $blks blocks, $bytes bytes" >> "$seqres.full"
> > > > >  _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
> > > > >  
> > > > > +rm -rf $testdir
> > > > 
> > > > Or put another way, this probably ought to be in _try_wipe_scratch_devs()
> > > 
> > > That's for devices I believe..
> > 
> > It exists to zap the scratch devices into enough of a clean state that
> > whatever contents a test wrote to the scratch devices cannot easily
> > (e.g. mount) leak into the next test.  IOWs, exactly where you'd want
> > FSTYP=NFS to delete whatever junk is in the scratch mount.
> > 
> > Plus then you get a clean nfs scratch mount at the start of each test
> > without needing to whackamole each test.
> > 
> > > Thanks,
> > > Murphy
> > > 
> > > > 
> > > > --D
> > > > 
> > > > >  # success, all done
> > > > >  status=0
> > > > >  exit
> > > > > diff --git a/tests/generic/176 b/tests/generic/176
> > > > > index a084578a..bc83762e 100755
> > > > > --- a/tests/generic/176
> > > > > +++ b/tests/generic/176
> > > > > @@ -73,6 +73,7 @@ bytes=$((blocks_needed * blksz))
> > > > >  echo "reflinking $((blocks_needed / 2)) blocks, $((bytes / 2)) bytes" >> "$seqres.full"
> > > > >  _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
> > > > >  
> > > > > +rm -rf $testdir
> > 
> > Also this will massively slow down generic/17[56] on btrfs/XFS
> > considering that we don't care about deleting the massively reflinked
> > file we created.
> 
> Deleting them would be a good testcase to me. After all the tests,
> deleting them should not cause any problem, or spending to much
> time. Leaving them behind and letting them get formatted by mkfs,
> definitely will be faster, but may make potential problems not
> discovered.

In that case, please rewrite the commit message to say that we're
enhancing this stress test to include inactivation of the files it
creates.

> If you think the deleting will be extremely slow, maybe it's time
> to optimize how xfs deleting reflinked files.

They already exist & have been out for review for years:

https://lore.kernel.org/linux-xfs/157784092020.1362752.15046503361741521784.stgit@magnolia/

--D

> 
> Thanks,
> Murphy
> 
> > 
> > --D
> > 
> > > > >  # success, all done
> > > > >  status=0
> > > > >  exit
> > > > > -- 
> > > > > 2.20.1
> > > > > 
