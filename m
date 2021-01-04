Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF50C43381
	for <linux-fstests@archiver.kernel.org>; Mon,  4 Jan 2021 22:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4C522515
	for <linux-fstests@archiver.kernel.org>; Mon,  4 Jan 2021 22:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbhADWVa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 4 Jan 2021 17:21:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33610 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbhADWV3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Jan 2021 17:21:29 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104MJQlk136049;
        Mon, 4 Jan 2021 22:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=2j6UHrv0O8JaCQFRk+/DjXZL5g2/uTq8E3PvtBVZoGU=;
 b=jpE+nR1+TbIajjHGh3oPBHMYdC7YsRObzNwnU4SBkRj5YTLyLRJZNxoiEvBmkcO9wcJy
 h0wp99AJmpVnelnii+w6uJage71EKEXWKPHY6NUCRNrjW7PbgOJqpwpQZzalCovP7G9L
 sK8iIKewXRUnLpLwqUECm+rfQftrw7IuosGBuHvH1YrD1JMm1f4a1OXZDTOBQdyqborS
 LVL0hiYp6RciApWV4zGBtUUpWIAgk/9A5ChiRsbMy5t9ebSv3zRX+Q6LUq5MHcOn6+E0
 O8U58HW3Ax8Idx3Gh9sySfv77g4BxgqvWLM3Fui0ZnEy/z1FBq30PQ8q7cJPGVZmVcZ3 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 35tg8qxetn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 22:20:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104MKKJa150860;
        Mon, 4 Jan 2021 22:20:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 35uxnrt1me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 22:20:38 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 104MKaMO014041;
        Mon, 4 Jan 2021 22:20:36 GMT
Received: from localhost (/10.159.152.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 22:20:36 +0000
Date:   Mon, 4 Jan 2021 14:20:35 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     Xiao Yang <yangx.jy@cn.fujitsu.com>,
        Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: master branch updated to 0ad1c034838d
Message-ID: <20210104222035.GC6919@magnolia>
References: <5fdf8221.1c69fb81.8c656.9b9d@mx.google.com>
 <5FDFF40A.7090702@cn.fujitsu.com>
 <20201221030702.GS80581@e18g06458.et15sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221030702.GS80581@e18g06458.et15sqa>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 phishscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040133
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Dec 21, 2020 at 11:07:02AM +0800, Eryu Guan wrote:
> On Mon, Dec 21, 2020 at 09:02:02AM +0800, Xiao Yang wrote:
> > On 2020/12/21 0:55, Eryu Guan wrote:
> > > Hi all,
> > >
> > > The master branch of the xfstests repository at:
> > >
> > > 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > >
> > > have just been updated. As usual, this update contains some new tests and
> > > various bug fixes and improvements.
> > >
> > > New btrfs tests btrfs/154 and btrfs/227 all currently fail with latest kernel.
> > > And xfs/513 has been updated to catch a xfs bug, but it should pass with latest
> > > kenrel.
> > >
> > > Also, unionmount tests has been improved to run with custom overlay mount
> > > options by assigning $OVERLAY_MOUNT_OPTIONS to UNIONMOUNT_MNTOPTIONS. You need
> > > to update your local unionmount tests to latest to contain commit 95be14e
> > > ("Allow user provided options with or without -o")
> > >
> > > Thanks,
> > > Eryu
> > >
> > > The new head of the master branch is commit:
> > >
> > > 0ad1c034838d overlay: run unionmount tests with custom overlay mount options
> > >
> > > New commits:
> > >
> > > Amir Goldstein (1):
> > >       [0ad1c034838d] overlay: run unionmount tests with custom overlay mount options
> > >
> > > Brian Foster (1):
> > >       [62cf7ce77f4f] generic/563: use a loop device to avoid partition incompatibility
> > >
> > > Eric Biggers (1):
> > >       [a225507009a3] generic: test for creating duplicate filenames in encrypted dir
> > >
> > > Feiyu Zhu (1):
> > >       [0c5013c565b7] src/t_enospc.c: Fix an error for the loop initialization declaration
> > >
> > > Filipe Manana (1):
> > >       [eabfcdfe9084] btrfs: test incremental send after removing a directory and all its files
> > >
> > > Kaixu Xia (1):
> > >       [c2dd12732f31] xfs/513: fix the regression caused by mount option uqnoenforce
> > >
> > > Nikolay Borisov (1):
> > >       [2a7406efecc2] btrfs: Update btrfs/215
> > >
> > > Ritesh Harjani (1):
> > >       [72dc169b442e] generic: Add test to check for mounting a huge sparse dm device
> > >
> > > Su Yue (1):
> > >       [a633d252e3c4] shared/032: add options for jffs2
> > >
> > > Xiao Yang (1):
> > >       [90d76997831e] src/multi_open_unlink: Stop using attr_set
> > Hi Eryu,
> > 
> > Only applying above patch broke the building of xfstests. :-)
> > See my explanation on the original patch set.
> 
> Thanks for the heads-up! That's weird, I didn't see compile error in my
> testing.. Will look into that.

Yes, this seems to have regressed in the last update in exactly the way
that Xiao Yang said in

https://lore.kernel.org/fstests/5FDFF2A4.6080909@cn.fujitsu.com/T/#m10968fc738f98815692bad1dee269071654255a0

Applying the dmiperf removal is definitely one way to fix it.

--D

> Thanks,
> Eryu
