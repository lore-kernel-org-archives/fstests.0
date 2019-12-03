Return-Path: <SRS0=DGTx=ZZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08AFC432C0
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Dec 2019 02:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CD2206DC
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Dec 2019 02:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R04yYoM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLCCjJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 2 Dec 2019 21:39:09 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60814 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfLCCjI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 Dec 2019 21:39:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB32ci7N075704;
        Tue, 3 Dec 2019 02:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=O1LwcexAeMc0UMWs6wcYu1QaoxhFOKKFa8DJJT2HuAM=;
 b=R04yYoM0Rgz42L2J7TCl9YsrK3UzLz4dbfeW1uFRVs0tPge4Oa6uSXA9/zWCFC2OLNjc
 X0/MSqY1jcqF4jh93qTW9d2L/u67T+pCLBA452cEEuFeWPy0rc82wzTcdh76q2JS6TYG
 xrMif0gQSYzQGTQMpXnOC+/28WSEE+Qr21ig7rGDDWsK+o0aCwupBFWBuY8cXA2pxF5D
 PteWUJnzS+s7cxpJnZWFx27719gJC96zTGNU8HsvezSQ2XMR2SRuYFBrPxyDQTEyQP8C
 p6C76jlK3vwaCMFpezZbXLo2xQRp6SnnUWMq/1GhXo+YNMKsR4X1Z/uBS0oiKSkZbOVA MA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2wkh2r44p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 02:39:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB32cuKm092568;
        Tue, 3 Dec 2019 02:39:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wn4qntmep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 02:38:59 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB32cIX9013502;
        Tue, 3 Dec 2019 02:38:18 GMT
Received: from localhost (/10.159.148.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Dec 2019 18:38:17 -0800
Date:   Mon, 2 Dec 2019 18:38:15 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/148: sort and filter attribute list output
Message-ID: <20191203023815.GB7328@magnolia>
References: <1574925045-7334-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191202232121.GD7339@magnolia>
 <297458b1-b8ad-3e88-e378-351faccc113b@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <297458b1-b8ad-3e88-e378-351faccc113b@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912030023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912030023
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Dec 03, 2019 at 09:45:58AM +0800, Yang Xu wrote:
> 
> 
> on 2019/12/03 7:21, Darrick J. Wong wrote:
> > On Thu, Nov 28, 2019 at 03:10:45PM +0800, Yang Xu wrote:
> > > When I backport fixed patches from Darrick tighten-verifiers tree, this case
> > 
> > NAK, why are you backporting out of my development tree and not upstream?
> My description is wrong. I use upstream kernel 5.4-rc8 and 4 attr patches as
> your tighten-verifiers tree do.
> > What are you even backporting, seeing as the patches for this are in 5.5
> > and Linus hasn't even pulled that yet??
> > I see Linus pulled the patches 3 hour ago,
> > Also, why are you sending a patch to fstests that is (a) barely a week
> > old, (b) doesn't actually list me as the author, and (c) I myself
> > haven't even sent to fstests yet?
> > 
> I  have listed you as author,  I think I should add  "Darrick J. Wong
> pointed  selinux and sort problem" info.  I find ls and "a_are_bad/for_you"
> problem.
> Also, in personal mail("Re: question about xfstests test case
> xfs/148(new)"), I said "I think you may  busy with other important things. I
> will send this simple patch with correct "a_are_bad/for_you" info and add
> your signed-off-by tag."). Anyway, I am sorry, I should have received your
> reply before sending the patch.

<nod> Apology accepted.  I'll send this (and everything else queueing in
my fstest tree) tomorrow like usual.

> > > also fails. As below:
> > > -----------------------------------------------------------
> > > "diff test/xfs/148.out result/xfs/148.out.bad
> > > 7,8d6
> > > < Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
> > > < Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/testfile
> > > 9a8
> > > > Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/testfile
> > > 10a10,11
> > > > Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
> > > > Attribute "selinux" has a 37 byte value for TEST_DIR/mount-148/testfile
> > > 49,50c50,51
> > > < Attribute "a_are_bad/for_you" had a 3 byte value for TEST_DIR/mount-148/testfile:
> > > < heh
> > > > attr_get: No data available
> > > > Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile"
> > > -------------------------------------------------------------
> > > We should sort attribute list output and filter selinux. Also "a_are_bad/for_you"
> > > doesn't exist, we should correct it in output.
> > > 
> > > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ...
> > > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> > > ---
> > >   tests/xfs/148     | 2 +-
> > >   tests/xfs/148.out | 8 ++++----
> > >   2 files changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/tests/xfs/148 b/tests/xfs/148
> > > index 42cfdab0..06862faa 100755
> > > --- a/tests/xfs/148
> > > +++ b/tests/xfs/148
> > > @@ -76,7 +76,7 @@ test_names+=("too_many" "are_bad/for_you")
> > >   access_stuff() {
> > >   	ls $testdir
> > > -	$ATTR_PROG -l $testfile
> > > +	$ATTR_PROG -l $testfile | grep "a_" | sort
> > >   	for name in "${test_names[@]}"; do
> > >   		ls "$testdir/f_$name"
> > > diff --git a/tests/xfs/148.out b/tests/xfs/148.out
> > > index c301ecb6..ab3fc25b 100644
> > > --- a/tests/xfs/148.out
> > > +++ b/tests/xfs/148.out
> > > @@ -4,10 +4,10 @@ f_another
> > >   f_are_bad_for_you
> > >   f_something
> > >   f_too_many_beans
> > > +Attribute "a_another" has a 3 byte value for TEST_DIR/mount-148/testfile
> > > +Attribute "a_are_bad_for_you" has a 3 byte value for TEST_DIR/mount-148/testfile
> > >   Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
> > >   Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/testfile
> > > -Attribute "a_are_bad_for_you" has a 3 byte value for TEST_DIR/mount-148/testfile
> > > -Attribute "a_another" has a 3 byte value for TEST_DIR/mount-148/testfile
> > >   TEST_DIR/mount-148/testdir/f_something
> > >   Attribute "a_something" had a 3 byte value for TEST_DIR/mount-148/testfile:
> > >   heh
> > > @@ -46,5 +46,5 @@ ls: cannot access 'TEST_DIR/mount-148/testdir/f_too_many': No such file or direc
> > >   attr_get: No data available
> > >   Could not get "a_too_many" for TEST_DIR/mount-148/testfile
> > >   ls: cannot access 'TEST_DIR/mount-148/testdir/f_are_bad/for_you': No such file or directory
> > > -Attribute "a_are_bad/for_you" had a 3 byte value for TEST_DIR/mount-148/testfile:
> > > -heh
> > > +attr_get: No data available
> > > +Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile
> > 
> > Huh?  Why???
> > 
> > NAK NAK NAK
> a_are_bad_for_you has been corrupted by "/". So it should be nothing such as

It's been changed, yes, but '/' is a valid character in an attribute
name.  Note that checksums are deliberately disabled on the loopdev
filesystem so that the only checks we perform are the name checks
themselves.

> a_too_many_beans by beans. am  I wrong?( I use 5.4-rc8 and 4 patches
> xfs: check attribute leaf block structure
> xfs: namecheck attribute names before listing them
> xfs: namecheck directory entry names before listing them
> xfs: replace -EIO with -EFSCORRUPTED for corrupt metadata
> ,this four patches from https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=tighten-verifiers

This is my development git repo ^^^^^^^^^^ which sometimes contains
older versions of patches that do not end up going upstream.

And this is the official xfs repo:
https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/

Anyway, Linus pulled the 5.5 patches now, so you *really* ought to be
backporting from that.

--D

> )>
> > 
> > --D
> > 
> > > -- 
> > > 2.18.0
> > > 
> > > 
> > > 
> > 
> > 
> 
> 
