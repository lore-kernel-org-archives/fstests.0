Return-Path: <SRS0=EYS7=3E=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB49C32771
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jan 2020 17:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723ED214AF
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jan 2020 17:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bJjNBfl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgAORT3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:19:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56630 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgAORT2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Jan 2020 12:19:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FHDCq7063144;
        Wed, 15 Jan 2020 17:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=1wGGSiMayuixqNNq6md031WKAXBxKouyhxuk5rHesJw=;
 b=bJjNBfl0BllDwux4IhXx18h6ogpehB5BXzZ5yChV9japHOQ+SwGOyW1FYpecVhBFEMMa
 x8bxcusVM2/5x8VfHqd16hEYKs7/8xj/Uzn0FlJr/RcRqFU0kZWyPWEgkyc7OCsfu4Ly
 I1NCVWG5kdWXkL4fgcSaZBuW5C5LR0OgZNkNsdX+QxsPchu6TZcXkpxMWqhj4ncWSNNR
 DixgJoKWHRckKm6orVaDkdAcw4U0ZFbW0PbQbBD2BAMGK+A00c+ozsYZlBbtsypGfHaB
 BABioOlB3XC8evsUN85BvsxbuGyZZzw/i7776Csj0KOVdsrZp9cuG5j6AklTh0T1P7qs tA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xf74sdh87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 17:19:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FHEEKt119077;
        Wed, 15 Jan 2020 17:19:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xj1prhemk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 17:19:26 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00FHJPrV000504;
        Wed, 15 Jan 2020 17:19:25 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 09:19:24 -0800
Date:   Wed, 15 Jan 2020 09:19:23 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/175, generic/176: cleanup testdir before exit
Message-ID: <20200115171923.GG8257@magnolia>
References: <20200113032409.11501-1-jencce.kernel@gmail.com>
 <20200113224203.GA8241@magnolia>
 <20200115042132.xl6ijsavac23x7dx@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115042132.xl6ijsavac23x7dx@xzhoux.usersys.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001150131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001150131
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 15, 2020 at 12:21:32PM +0800, Murphy Zhou wrote:
> On Mon, Jan 13, 2020 at 02:42:03PM -0800, Darrick J. Wong wrote:
> > On Mon, Jan 13, 2020 at 11:24:09AM +0800, Murphy Zhou wrote:
> > > Usually the _mkfs helper will cleanup these directories at the
> > > beginning of testcase. However, when testing on NFS, the cleanup
> > > could be very slow and it is confusing that: We have already
> > > started to run generic/176 but we get stuck in _mkfs, cleaning
> > > up files left by the previous testcase generic/175.
> > 
> > Isn't this a general problem with the way nfs handles "mkfs" on scratch
> > devices?  So you'd want to fix this once by doing the cleanup between
> > tests instead of playing whackamole with whatever crazy file tests we
> > think of next?
> 
> Hmm, it's hard to tell. Deleting these files at anywhere makes sense.
> This patch is hardly a "fix", just trying to make it more clear.
> 
> > 
> > > To be clear, cleanup testdir before exit.
> > > 
> > > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > > ---
> > >  tests/generic/175 | 1 +
> > >  tests/generic/176 | 1 +
> > >  2 files changed, 2 insertions(+)
> > > 
> > > diff --git a/tests/generic/175 b/tests/generic/175
> > > index 79e5b3d6..bd966a28 100755
> > > --- a/tests/generic/175
> > > +++ b/tests/generic/175
> > > @@ -61,6 +61,7 @@ bytes=$((blks * blksz))
> > >  echo "reflinking $blks blocks, $bytes bytes" >> "$seqres.full"
> > >  _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
> > >  
> > > +rm -rf $testdir
> > 
> > Or put another way, this probably ought to be in _try_wipe_scratch_devs()
> 
> That's for devices I believe..

It exists to zap the scratch devices into enough of a clean state that
whatever contents a test wrote to the scratch devices cannot easily
(e.g. mount) leak into the next test.  IOWs, exactly where you'd want
FSTYP=NFS to delete whatever junk is in the scratch mount.

Plus then you get a clean nfs scratch mount at the start of each test
without needing to whackamole each test.

> Thanks,
> Murphy
> 
> > 
> > --D
> > 
> > >  # success, all done
> > >  status=0
> > >  exit
> > > diff --git a/tests/generic/176 b/tests/generic/176
> > > index a084578a..bc83762e 100755
> > > --- a/tests/generic/176
> > > +++ b/tests/generic/176
> > > @@ -73,6 +73,7 @@ bytes=$((blocks_needed * blksz))
> > >  echo "reflinking $((blocks_needed / 2)) blocks, $((bytes / 2)) bytes" >> "$seqres.full"
> > >  _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
> > >  
> > > +rm -rf $testdir

Also this will massively slow down generic/17[56] on btrfs/XFS
considering that we don't care about deleting the massively reflinked
file we created.

--D

> > >  # success, all done
> > >  status=0
> > >  exit
> > > -- 
> > > 2.20.1
> > > 
