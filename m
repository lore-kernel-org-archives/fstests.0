Return-Path: <SRS0=5Vws=Y5=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A26AC010A2
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Nov 2019 11:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF2A21D7F
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Nov 2019 11:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbfKELyh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:54:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfKELyh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 5 Nov 2019 06:54:37 -0500
Received: from mbp (unknown [46.69.195.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 006B621D6C;
        Tue,  5 Nov 2019 11:54:34 +0000 (UTC)
Date:   Tue, 5 Nov 2019 11:54:31 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Theodore Tso <tytso@mit.edu>, fstests <fstests@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 5.4-rc1 boot regression with kmemleak enabled
Message-ID: <20191105115431.GD26580@mbp>
References: <CAOQ4uxgy6THDG2NsNSQ+=FP+iSZKeCkNEM9PbxQSB5p5nHvoCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgy6THDG2NsNSQ+=FP+iSZKeCkNEM9PbxQSB5p5nHvoCA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

(sorry if you got this message twice; our SMTP server went bust)

On Tue, Nov 05, 2019 at 09:14:06AM +0200, Amir Goldstein wrote:
> My kvm-xfstests [1] VM doesn't boot with kmemleak enabled since commit
> c5665868183f ("mm: kmemleak: use the memory pool for early allocations").
> 
> There is no console output when running:
> 
> $ kvm -boot order=c -net none -machine type=pc,accel=kvm:tcg -cpu host \
>     -drive file=$ROOTFS,if=virtio,snapshot=on -vga none -nographic \
>     -smp 2 -m 2048 -serial mon:stdio --kernel $KERNEL \
>     --append 'root=/dev/vda console=ttyS0,115200'

This was fixed in 5.4-rc4, see commit 2abd839aa7e6 ("kmemleak: Do not
corrupt the object_list during clean-up").

-- 
Catalin
