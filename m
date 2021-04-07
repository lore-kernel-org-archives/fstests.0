Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B039C433ED
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Apr 2021 18:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487366108B
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Apr 2021 18:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355082AbhDGSEB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Apr 2021 14:04:01 -0400
Received: from sandeen.net ([63.231.237.45]:51592 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355083AbhDGSEA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 7 Apr 2021 14:04:00 -0400
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id D9D99335045;
        Wed,  7 Apr 2021 13:02:50 -0500 (CDT)
To:     Pavel Reichl <preichl@redhat.com>, fstests@vger.kernel.org
Cc:     zlang@redhat.com, guan@eryu.me
References: <20210330220005.56019-1-preichl@redhat.com>
 <20210330220005.56019-5-preichl@redhat.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH v2 4/4] generic/003: Amend the test for exfat
Message-ID: <47a498f6-ae69-7518-717c-8010bf917980@sandeen.net>
Date:   Wed, 7 Apr 2021 13:03:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210330220005.56019-5-preichl@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 3/30/21 5:00 PM, Pavel Reichl wrote:
> Update the test so it can be run even for exfat which has 2 seconds
> granularity for access_time and does not have a timestamp for
> metadata change.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>

This looks a whole lot like what I was playing with earlier.  :)

Can you run it say 20 times in a row, and make sure that you don't get
spurious failures by sleeping for /exactly/ the atime granularity?

Thanks,
-Eric
