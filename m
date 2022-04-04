Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BF4C433EF
	for <linux-fstests@archiver.kernel.org>; Mon,  4 Apr 2022 15:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378345AbiDDPnQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 4 Apr 2022 11:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378683AbiDDPnD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Apr 2022 11:43:03 -0400
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Apr 2022 08:41:06 PDT
Received: from sandeen.net (sandeen.net [63.231.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD3BC393F5
        for <fstests@vger.kernel.org>; Mon,  4 Apr 2022 08:41:06 -0700 (PDT)
Received: from [10.0.0.146] (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id E68B62AEE;
        Mon,  4 Apr 2022 10:34:11 -0500 (CDT)
Message-ID: <f73b9664-d3fc-0b95-e458-27860d87287a@sandeen.net>
Date:   Mon, 4 Apr 2022 10:36:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Content-Language: en-US
To:     Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org
References: <Yjdmj0lVqCbbbjW8@desktop>
 <20220321161935.46g3n22wbv5bfnyq@zlang-mailbox>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: maintainership of fstests
In-Reply-To: <20220321161935.46g3n22wbv5bfnyq@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 3/21/22 11:19 AM, Zorro Lang wrote:
> On Mon, Mar 21, 2022 at 01:38:23AM +0800, Eryu Guan wrote:
>> Hi folks,
>>
>> It's almost 6 years since I've taken the maintainership of fstests, and
>> I tried my best to keep the pace of weekly update, or at least bi-weekly
>> update due to something like public holidays.
>>
>> But it's been a month since last fstests update due to my personal
>> urgent issues, and some patches got no review for more than one month.
>> So I think it's time to re-consider the maintainership of fstests.
>>
>> I will have less spare time in the foreseeable future, as I have to
>> spend more time on my family, so it's hard to keep the weekly update
>> pace. And six years is a long time, I think it's time to have a new
>> maintainer.
> 
> Hi Eryu,
> 
> By thinking about it a while, I get up my courage to apply this job, although I
> know I'm not the best one can handle this job. Just this project is really
> useful for my team. Nearly from I joined Red Hat, my jobs started to around the
> xfstests. It's a great testsuit, which can cover most of our testing. I felt
> relieved when you toke this maintainer, and admired your courage at that time,
> that really helps us a lot. No matter what you decide, thanks again for all your
> help, as previous colleague, as friend.

Hi Zorro - I'm sure that you would do well as a new maintainer, even if it
requires some learning. Every new challenge requires learning. :) If you are able
to balance it with your other tasks, I would be happy to see you take this on,
if it's something you want to do.

(See also Darrick's suggestion that maintainer tasks could be split up a bit,
across the different filesystems.)

Thanks,
-Eric

> Thanks,
> Zorro
> 
>>
>> Or we could go to the group-maintain way? As Darrick mentioned before
>> (for xfs not fstests, if I recall correctly). Then we need a new primary
>> maintainer :)
>>
>> What do you think?
>>
>> Thanks,
>> Eryu
>>
>> P.S.
>> I'll keep the maintainer role and do the review & update as usual until
>> all things settle down.
>>
> 
