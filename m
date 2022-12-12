Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF622C4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Dec 2022 03:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiLLD27 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 11 Dec 2022 22:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiLLD2x (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Dec 2022 22:28:53 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8855B493
        for <fstests@vger.kernel.org>; Sun, 11 Dec 2022 19:28:52 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=0;PH=DS;RN=3;SR=0;TI=SMTPD_---0VX0wjfJ_1670815729;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VX0wjfJ_1670815729)
          by smtp.aliyun-inc.com;
          Mon, 12 Dec 2022 11:28:50 +0800
Date:   Mon, 12 Dec 2022 11:28:48 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        fstests <fstests@vger.kernel.org>
Subject: Re: supporting overlay+tmpfs breaks check -n -overlay -g auto
Message-ID: <Y5af8G3Fntl841fo@B-P7TQMD6M-0146.local>
References: <CADJHv_sJHyhgaJoAJCZY0VpO6u8vGHOzD3qBgv5EW3vYSNjfuA@mail.gmail.com>
 <a4844c99-77f4-470f-f351-a82155b5eca7@huawei.com>
 <Y5aTu/fP6C3ZNPjI@B-P7TQMD6M-0146.local>
 <34a30ec2-9c19-8cf9-2156-eaf62fe6d8c6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34a30ec2-9c19-8cf9-2156-eaf62fe6d8c6@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Dec 12, 2022 at 11:03:04AM +0800, Baokun Li wrote:
> On 2022/12/12 10:36, Gao Xiang wrote:
> > On Mon, Dec 12, 2022 at 10:08:33AM +0800, Baokun Li wrote:
> > > On 2022/12/12 9:42, Murphy Zhou wrote:
> > > > Hi,
> > > > 
> > > > Bisecting points me to this commit:
> > > > 
> > > > commit 92fb58afaa2f38a9369ad5791a4cbf135545617d
> > > > Author: Baokun Li <libaokun1@huawei.com>
> > > > Date:   Wed May 11 16:34:04 2022 +0800
> > > > 
> > > >       common: xfstests support overlay+tmpfs
> > > > 
> > > > 
> > > > It breaks this command:
> > > > ./check -n -overlay -g auto
> > > > 
> > > > As a result, it fails to show me the list of testcases.
> > > > 
> > > > Please help to check.
> > > > 
> > > > Thanks!
> > > > Murphy
> > > I tried to run the command on the latest version, and everything was fine.
> > > 
> > > Did I miss anything?
> > > 
> > > What is the version, environment, and config for reproducing the problem?
> > > 
> > Just to mention that we've also encountered this issue by doing
> > 
> > FSTYP=ext4
> > ./check -overlay generic/192
> > 
> > it seems the workaround would be:
> > 1) add an environment variable: export OVL_BASE_FSTYP=ext4
> > or
> > 2) update ./check and delete:
> > 
> > # Process command arguments first.
> > while [ $# -gt 0 ]; do
> >          case "$1" in
> >          -\? | -h | --help) usage ;;
> > 
> >          -nfs|-glusterfs|-cifs|-9p|-virtiofs|-pvfs2|-tmpfs|-ubifs)
> >                  FSTYP="${1:1}"
> >                  ;;
> >          -overlay)
> >                  FSTYP=overlay
> >                      ^ remove this
> >                  export OVERLAY=true
> >                  ;;>
> > 
> > Thanks,
> > Gao Xiang
> > 
> I also tested this use case and the results are as follows, and the test is
> passed.
> 
>     [root@fedora xfstest]# export OVL_BASE_FSTYP=ext4
>     [root@fedora xfstest]# ./check -overlay generic/192


Did you actually see my comments above? I meant

export FSTYP=ext4
./check -overlay generic/192

*NOT* export OVL_BASE_FSTYP=ext4 here.

Thanks,
Gao Xiang
