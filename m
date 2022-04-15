Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C274C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 15 Apr 2022 08:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiDOI37 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 15 Apr 2022 04:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243946AbiDOI37 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 15 Apr 2022 04:29:59 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A81B2463
        for <fstests@vger.kernel.org>; Fri, 15 Apr 2022 01:27:31 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id n17so3890612ljc.11
        for <fstests@vger.kernel.org>; Fri, 15 Apr 2022 01:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=auPg62IBS7/cD6oG1XlfbRh1wN3FvB2dUGJnGka0Cdg=;
        b=dGJmZ6UDzDbJSaaTs/q47rDgRT0qcTi96jZLHHP6wP4CKpLBnS1H6FCjhbeJ4g8DzX
         dKn20Rfzz4YXWK7lBnYVUVaYqQLrogwhTFyq5Th+xoT5bMbexQAYgcpNzdnlBwRuyCuP
         dE9w5LVgEeMyvA6OlwTXfPoPd82mlSTG6hUEfe4GGEhsJpJPCPlCcRfkusL2qNrltBto
         0+D9ogDItDOPAlwPwt50XHSk/A2vNQdRVRsiHD7eDk5NCsRBolFVDY9a+L78onKwUjmz
         rlTxDbIO0/sIshxdickNOGvQCDDZ2v2drFbAXWkPQv53GsJxhlR7LQY+WV6hQEJPlB8F
         MRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=auPg62IBS7/cD6oG1XlfbRh1wN3FvB2dUGJnGka0Cdg=;
        b=hRBJSWGsStjBJNYK6MMbZJXuEp70j9/Fu5Vaj7w9KaWRNJlSqQ/M9WK8uA8tDGUt1h
         Qdg42v+ghF8yRvRQfURU4kDWIjqCPTZNbzUZ/V5Tk0vUcxT+akMnT1p6LHpAclfbiTEb
         WQgc05Chapr5wlwNs7Lqw7j35EUJrzGk069MbHebpTr4yb7aGvgKX1w/5J0cDPct+orh
         inR8xg18mv13lquAsdWrtQbueNWiQNtC0HfnBmthGd356W6xKZzvgpLD0X8l08h+uMRZ
         7FufBEBoDqC0CmPPJQE09FxTC5N3mdP6X0G+fM/x+FxJUIPTbKniGCm70AlmN8VVWBr1
         BMXw==
X-Gm-Message-State: AOAM532vyQKUykS8pvzJnsfr30sHUWWgPbKlPmu/BAEMKVW4t7BnuNXC
        +7Su5RQ5OSC+/U9spyxK8jDUVmuUqQmspg==
X-Google-Smtp-Source: ABdhPJw1hmpsYFKYBDiuTTv+RRphagCPZ8Narai1V/5DV0SMSaT/gVY04IQSxypXQ+bS5E8T3Aw4sw==
X-Received: by 2002:a2e:bd09:0:b0:24b:9e3:30c6 with SMTP id n9-20020a2ebd09000000b0024b09e330c6mr3680364ljq.282.1650011249525;
        Fri, 15 Apr 2022 01:27:29 -0700 (PDT)
Received: from ?IPV6:2001:14ba:9cae:8c00:9682:e720:334f:2fac? (dxw3k4yf2tnxwyp6sg02y-3.rev.dnainternet.fi. [2001:14ba:9cae:8c00:9682:e720:334f:2fac])
        by smtp.gmail.com with ESMTPSA id k4-20020a2e8884000000b0024c91d2c8a8sm210488lji.105.2022.04.15.01.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 01:27:28 -0700 (PDT)
Message-ID: <4c3952e0-228e-362b-fecc-ff975af2880c@gmail.com>
Date:   Fri, 15 Apr 2022 11:27:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [xfstests-bld PATCH 0/2] Make ntfs3 more usable
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Kari Argillander <kari.argillander@fidelix.com>,
        fstests@vger.kernel.org
References: <20220414234220.627320-1-kari.argillander@fidelix.com>
 <Yljy7qjf6KDj64NN@mit.edu>
From:   Kari Argillander <kari.argillander@gmail.com>
In-Reply-To: <Yljy7qjf6KDj64NN@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 15.4.2022 7.22, Theodore Ts'o wrote:
> On Fri, Apr 15, 2022 at 02:42:18AM +0300, Kari Argillander wrote:
>> Add ntfs3 kernel configs and disable tests which hangs at the moment.
>>
>> Kari Argillander (2):
>>    test-appliance: Add exclude file for ntfs3
>>    kernel-configs: add ntfs3 to current 5.15 configs
> 
> Note that upstream fstests does *not* have support for ntfs3 at the
> moment.  I have some admittedly very hacky patches in my personal fork
> of xfstests on github, but they use a mix of userspace tools that are
> specific for other ntfs file system drivers, since last I checked,
> Paragon software has not made open source file system utilities for
> ntfs3 available.

Yes I'm fully aware of situation. I just try to make situation little 
bit better and have to start somewhere. Hopefully someone other will 
also start gain interest developing this if tools are easier to use.

> The support of ntfs3 in {kvm,gce}-xfstests was experimental in nature
> when I was trying to make an assessment about whether ntfs3 was ready
> for prime time.  So don't mind applying these patches, but I'm
> currently no longer regularly running ntfs3 test runs, and I'm very
> much aware that the current ntfs3 support that I had added a while
> back into xfstests is definitely not polished or ready for the fstests
> maintainer to consider accepting.
I also planning to do better Xfstests support for ntfs3. Your tool at 
the moment is still only way testing it for new developers so I just 
want it to be little bit easier. I do not except you to run ntfs3. I 
also know about your previes patch. I will polish that to be usable.

I have also made ntfs3 support for Syzkaller and my patch will probably 
be merged this week. It means next week there will probably start coming 
some bug reports from there too. Local Syzkaller run against ntfs3 does 
not see very promising and there will be some bugs. But hey testing 
helps as we see how buggy things are.

Thing is that Konstantin (ntfs3 maintainer) has kept totally radio 
silence after 5.15 was released. I will make own thread about it soon as 
ntfs3 is orphan already. But that will need definitely own thread.

     Argillander

> Cheers,
> 
> 					- Ted
