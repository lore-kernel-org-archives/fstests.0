Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56513C433B4
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Apr 2021 16:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 290FD6108B
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Apr 2021 16:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245564AbhDGQrR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Apr 2021 12:47:17 -0400
Received: from sandeen.net ([63.231.237.45]:47810 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234029AbhDGQrQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 7 Apr 2021 12:47:16 -0400
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 126675EDA8;
        Wed,  7 Apr 2021 11:46:05 -0500 (CDT)
To:     Pavel Reichl <preichl@redhat.com>,
        Eryu Guan <eguan@linux.alibaba.com>
Cc:     fstests@vger.kernel.org, zlang@redhat.com, guan@eryu.me,
        Eric Sandeen <sandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>
References: <20210330220005.56019-1-preichl@redhat.com>
 <20210330220005.56019-2-preichl@redhat.com>
 <20210401033853.GO95214@e18g06458.et15sqa>
 <9f6d45ca-7f96-1cfa-5e66-a355ad4e0c7a@redhat.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH v2 1/4] common/rc: Add _require_{chown,chmod,symlink}()
Message-ID: <38e0b763-3d0b-9fdb-7df0-b3c526785364@sandeen.net>
Date:   Wed, 7 Apr 2021 11:47:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <9f6d45ca-7f96-1cfa-5e66-a355ad4e0c7a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 4/1/21 4:47 AM, Pavel Reichl wrote:
>> We only use whitelist if it's impossible to do such check.
>>
>> Thanks,
>> Eryu
>>
> Hi, 
> 
> it does fail. It was actually my original intention to write the _require*() so it would check if the command succeeds as you are suggesting.
> 
> However, Eric and Dave were worried that adding more _require*() through the tests would lead to further slowing test execution. This worry actually makes sense to me.
> 
> Is there a significant benefit of testing the support vs. maintaining check based on FSTYP variable? I guess doing the check saves us from the need to update the code when new file-system is added, however actually doing the check increases time of test execution (but I haven't done any measurements yet - it's just my guess).
> 
> I really don't mind doing it either way and I'm happy to change the code - I'm just trying to explain :-)

that's my fault, sorry.  Dave had expressed some concern about exfat changes slowing down testing for every other fs, and we talked about a whitelist.  But now that I think about it, I'm not sure this functiona test takes any real extra time.

Pavel, maybe you can just evaluate whether there really is any significant time difference, and if there is not, go back to the functional test.

Sorry for the hassle.

-Eric
