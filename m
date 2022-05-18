Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E618EC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 18 May 2022 00:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiERAKZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 May 2022 20:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiERAKY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 May 2022 20:10:24 -0400
Received: from sandeen.net (sandeen.net [63.231.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D42FEB87A
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 17:10:22 -0700 (PDT)
Received: from [10.0.0.146] (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id C16CA323BE2;
        Tue, 17 May 2022 19:10:09 -0500 (CDT)
Message-ID: <4e7ba166-15a0-6560-da42-47c0c6ad9935@sandeen.net>
Date:   Tue, 17 May 2022 19:10:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
References: <20220516085922.1306879-1-david@fromorbit.com>
 <20220516085922.1306879-2-david@fromorbit.com> <YoJ5yvYD9ZmNoNVi@magnolia>
 <20220516213516.GL2306852@dread.disaster.area> <YoLPfAi8sZH99FuV@magnolia>
 <20220517043603.GN2306852@dread.disaster.area>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH 1/4] fstests: fix group list generation for whacky test
 names
In-Reply-To: <20220517043603.GN2306852@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 5/16/22 11:36 PM, Dave Chinner wrote:
> On Mon, May 16, 2022 at 03:26:04PM -0700, Darrick J. Wong wrote:
...
>> Did _anyone_ actually compare the group.list output before and after
>> applying the patch?

...

> I Am Not A Happy Camper.

...

And this whole thing has made me Very Sad.

Everybody's trying to do the right thing here. Darrick's original patch
tried to ease maintainer burden with group file conflicts. Dave's patch
tried to speed it up. Zorro reviewed it, cycled it through for-next and
landed it in main in a timely manner. A problem or two remained, and now
everybody's... angry. Of course.

Can we try to just show a little more grace here? Assume good intent?
Interpret things as charitably as possible? Voice concerns calmly, and
hear them nondefensively? Accept that mistakes will happen, fix them, and
move forward? It would go a long ways to making this all a lot more fun.

I'm coming at this without most of the technical context or background
for these changes. All of the issues raised seem reasonable to me:
slowing down "make" has some drawbacks. Special requirements on lines
of bash has drawbacks too. None of this is insurmountable. Document
the specialness in the template. Make the parsing more robust, or make
it fail in a more obvious way. Spend time on yet another approach to
generate group files efficiently, if that's worth it ... I dunno.

But we've got to be able to get through relatively minor issues like
this without tempers flaring, it's just not worth it.

It's not my intent to take sides or point fingers in this particular
exchange, it's just that this dynamic has played out too many times
recently, and I really wish we could collectively do better. It's not
good for us as individuals or as a community.

-Eric
