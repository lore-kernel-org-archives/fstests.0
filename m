Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C06C433ED
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Apr 2021 14:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF879610E9
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Apr 2021 14:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhDKOaj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 11 Apr 2021 10:30:39 -0400
Received: from out20-51.mail.aliyun.com ([115.124.20.51]:39403 "EHLO
        out20-51.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDKOai (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Apr 2021 10:30:38 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08874168|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0131437-0.000353558-0.986503;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=guan@eryu.me;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.JyKqk8I_1618151420;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JyKqk8I_1618151420)
          by smtp.aliyun-inc.com(10.147.40.2);
          Sun, 11 Apr 2021 22:30:20 +0800
Date:   Sun, 11 Apr 2021 22:30:20 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v12 2/6] generic/632: add fstests for idmapped mounts
Message-ID: <YHMH/JRmzg3ETcED@desktop>
References: <20210328223400.1800301-1-brauner@kernel.org>
 <20210328223400.1800301-3-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328223400.1800301-3-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 29, 2021 at 12:33:56AM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Add a test suite to verify the behavior of idmapped mounts. The test
> suite also includes a range of vfs tests to verify that no regressions
> are introduced by idmapped mounts. The following tests are currently
> available with more to come in the future:
> 
> 01. posix acls on regular and idmapped mounts

I'm getting failures like below when testing on btrfs and overlayfs

[root@fedoravm xfstests]# diff -u
/root/workspace/xfstests/tests/generic/633.out /root/workspace/xfstests/results//btrfs/generic/633.out.bad
--- /root/workspace/xfstests/tests/generic/633.out      2021-04-11 22:18: 24.458518716 +0800
+++ /root/workspace/xfstests/results//btrfs/generic/633.out.bad 2021-04-11 22:19:58.887980770 +0800
@@ -1,2 +1,4 @@
 QA output created by 633
  Silence is golden
  +idmapped-mounts.c: 6622: acls - Invalid argument - failure: sys_mount_setattr
  +failure: posix acls on regular mounts

Is this a known issue or test needs some fix?

[snip]

>  create mode 100644 tests/generic/632

Please change mode of new test file to 755 if you end up with sending
new version, otherwise I can fix it on commit.

Thanks,
Eryu
