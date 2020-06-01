Return-Path: <SRS0=lb/K=7O=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCAAC433DF
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Jun 2020 03:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380F72073B
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Jun 2020 03:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lj/d8xeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgFADz6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 31 May 2020 23:55:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47674 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726002AbgFADz6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 31 May 2020 23:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590983756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DkIeOV+m6HLGvxNAbQH7HvwoD/vYo/UI6ub4N3rSCmQ=;
        b=Lj/d8xeqS2OhjhS8pRLqPTrEvfMGhDuHNgDTsUKV6z/Yipj8USgGaxQEbnqcfIfm+U/AGN
        SywKEHvylojy8kFKm3VMnBBm6b3HjVek3OQU4G5JbY+5eOceb8+EnZYKs3n2dDuQ2UGsvu
        MUBa7422QvGj1AI21DtPJVotgWP51Bk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-1dzyn1QDMNm0l8px7NHIlg-1; Sun, 31 May 2020 23:55:54 -0400
X-MC-Unique: 1dzyn1QDMNm0l8px7NHIlg-1
Received: by mail-pj1-f69.google.com with SMTP id k10so7321763pjj.4
        for <fstests@vger.kernel.org>; Sun, 31 May 2020 20:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DkIeOV+m6HLGvxNAbQH7HvwoD/vYo/UI6ub4N3rSCmQ=;
        b=X6ZxQbXrSojbE7jCTJawc5TR4aEh+QygS5NmIpHiDG1gZmW6MRYNm2I6faS8kHmnF/
         GOnzRV/Df+vXakEDhQOJHjLvaQtn5LU6mjd+7WIsTxTELakRSkIkKjLCRSO6b7TqeLIe
         mK2wndm2ruhiHNgfM8cqZfleHVueBtBp35QUAjeWo/Tdo82Id1yRPdpo54G3t+7OjOYd
         bd3pMd9FpS+SDWUzp62X9vJ73z+cCquaZoWX7PulrRYlONaSQUNl+cVczPdH2CSlnhwd
         UUoCHknJZd/bHhMTyVKU4An8ECGuCDBbEoNc7nGylX8cOborYZeblHAmul8dUMdtLnJg
         djLQ==
X-Gm-Message-State: AOAM533oaTMgsjXKy0dFdCaB7e5Vt6pFFz605qjvyZsVFI1ACsJ7mUiD
        igG40Xk9RAKfuAuatmaJvJsahmxNhK+6otYnCrWq/SazCYzTyhA5QfNle2aHgHJDAYHR/D03b4y
        gL9CGsTE2L66OVoD0Zg==
X-Received: by 2002:a17:902:9895:: with SMTP id s21mr19189698plp.335.1590983753996;
        Sun, 31 May 2020 20:55:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxli31ghAqpkGsyBDiBvd3G38Al6DzzroprVZfYByIB8ppzhJfk3qMj+g2ChAEUyQ0sdrnrYw==
X-Received: by 2002:a17:902:9895:: with SMTP id s21mr19189683plp.335.1590983753730;
        Sun, 31 May 2020 20:55:53 -0700 (PDT)
Received: from don.don ([60.224.129.195])
        by smtp.gmail.com with ESMTPSA id ca6sm459723pjb.46.2020.05.31.20.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2020 20:55:53 -0700 (PDT)
Subject: Re: [PATCH v2] xfstests: add test for xfs_repair progress reporting
From:   Donald Douwsma <ddouwsma@redhat.com>
To:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
References: <20200519160125.GB17621@magnolia>
 <20200520035258.298516-1-ddouwsma@redhat.com>
 <20200529080640.GH1938@dhcp-12-102.nay.redhat.com>
 <3097a996-c661-d03f-a3e6-aa60ea808f04@redhat.com>
Message-ID: <41124f57-55e6-68c4-ef90-b51fc5e3b68f@redhat.com>
Date:   Mon, 1 Jun 2020 13:55:49 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3097a996-c661-d03f-a3e6-aa60ea808f04@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 01/06/2020 10:53, Donald Douwsma wrote:
> Hi Zorro,
> 
> On 29/05/2020 18:06, Zorro Lang wrote:
>> On Wed, May 20, 2020 at 01:52:58PM +1000, Donald Douwsma wrote:

<snip>

>>> --- a/tests/xfs/group
>>> +++ b/tests/xfs/group
>>> @@ -513,3 +513,4 @@
>>>  513 auto mount
>>>  514 auto quick db
>>>  515 auto quick quota
>>> +516 repair
>>
>> Is there a reason why this case shouldn't be in auto group?
>>
>> Thanks,
>> Zorro
> 
> 
> We could work to wards getting it into auto, I wanted to make sure it
> was working ok first.
> 
> It takes about 2.5 min to run with the current image used by
> _scratch_populate_cached, by its nature it needs time for the progress
> code to fire, but that may be ok.
> 
> It sometimes leaves the delay-test active, I think because I've I used
> _dmsetup_remove in _cleanup instead of _cleanup_delay because the later
> unmounts the filesystem, which this test doesnt do, but I'd have to look
> into this more so it plays well with other tests like the original
> dmdelay unmount test 311.

Actually it does clean up delay-test correctly (*cough* I may have been
backgrounding xfs_repair in my xfstests tree while testing something
else).  I have seen it leave delay-test around if terminated with 
ctrl+c, but that seems reasonable if a test is aborted. 

> I wasn't completely happy with the filter, it only checks that any of the
> progress messages are printing at least once, which for most can still
> just match on the end of phase printing, which always worked. Ideally it
> would check that some of these messages print multiple times.
> 
> I can work on a V3 if this hasn't merged yet, or a follow up after, thoughts?
> 


