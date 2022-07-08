Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B65C433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Jul 2022 16:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbiGHQhG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 Jul 2022 12:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238690AbiGHQhF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Jul 2022 12:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AB0D19C23
        for <fstests@vger.kernel.org>; Fri,  8 Jul 2022 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657298223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Zr0jbSDEiPewoOYQiS8jt5xohMJS4RyFoMUqblRWb4=;
        b=JcBQPDIiLbT8qfklKwE7WjmkNx4gV/7m/VOwwCCUj25h6pVHXuOj2YeHBYf/+i906xEp+K
        C4/o8cwkt/WAfLaRF1J9NOnYo7y26nX7SFvtsMEWDdt+/xw/+Qn5nls22fbkYc0tui1kFg
        y3fAiZ5lJKchJ8ruE5RpvjGiwDsU+Y4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-Vd38uiT1Mney_LQsYN4kTg-1; Fri, 08 Jul 2022 12:37:02 -0400
X-MC-Unique: Vd38uiT1Mney_LQsYN4kTg-1
Received: by mail-qk1-f198.google.com with SMTP id l15-20020a05620a28cf00b006b46997c070so14672277qkp.20
        for <fstests@vger.kernel.org>; Fri, 08 Jul 2022 09:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Zr0jbSDEiPewoOYQiS8jt5xohMJS4RyFoMUqblRWb4=;
        b=b69VmvLMXTOjfOAFjcmwMHSB1i3xtSAA2x75nAttxqdUPAB8Q/wMuqO82aseLQDCkN
         +fBuyJ+c2oXsmar6HffS97PV454ePluT8vrywM55WmVfRzlSqmgqwQCai9v3Prr9RQKu
         5VlqFwxNYRaAOdS0EUFJBOW8BnUJV+V6r/KY4O0kTz3VMd4/ORtTJ2AislkRyyV0mfzd
         MLLNgwmF1DK6fqDtSW6rtQuyjo1fGR78u9G6P48jDDm3L6CF0vbk7jB4zUtmBywMEI4h
         3NoSU7HPOQ51xKcmbVhJaP6T2Tf1RzmCCYE4Yv97Xgqwv5Hn4u9F/MXkOmfYMoVuT4G8
         cCWw==
X-Gm-Message-State: AJIora+mig7wg78Z5wknfNwRJ5EfcQpJ6/CkTw2XyKpt1siVMjX4MIi3
        lVnywo9WUma9nrgMTBFLLXedx2crlEg5IKkMYPZyTelhWkqsyv9NEhl2HQTPeepVZnKqVfNzfKf
        7kJBCHjp3Mb7SznO2Rg==
X-Received: by 2002:a05:6214:20e4:b0:472:f202:e5c9 with SMTP id 4-20020a05621420e400b00472f202e5c9mr3435930qvk.117.1657298221777;
        Fri, 08 Jul 2022 09:37:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tLodHqnMICc3jBUKWfFxKS8MZ0KSELXWib57FdwdsymYtEgFHgG/9uQS0BGeTCQ1NH1J9DcQ==
X-Received: by 2002:a05:6214:20e4:b0:472:f202:e5c9 with SMTP id 4-20020a05621420e400b00472f202e5c9mr3435909qvk.117.1657298221487;
        Fri, 08 Jul 2022 09:37:01 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b19-20020ae9eb13000000b006aee672937esm33860039qkg.37.2022.07.08.09.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:37:00 -0700 (PDT)
Date:   Sat, 9 Jul 2022 00:36:54 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, tytso@mit.edu, djwong@kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 0/5] check: add option to rerun failed tests
Message-ID: <20220708163654.7luwvjfdn4ep5jgw@zlang-mailbox>
References: <20220708085142.20991-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708085142.20991-1-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jul 08, 2022 at 10:51:37AM +0200, David Disseldorp wrote:
> This patchset adds support to loop on failed tests, as proposed by
> Ted Ts'o in https://lwn.net/Articles/897061/:
>   add a mode that will immediately rerun a failed test 25 or 100 times
>   to establish a failure percentage.

This patchset is good to me. if no more objections, I think it's time
to merge this feature. I'll give it a testing, then try to push it
this weekend.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> 
> Changes since (v3), following Darrick's review:
> - extended full/out.bad/etc. retention to cover more paths and remove
>   stale .rerun# files
> 
> Changes since (v2), following Darrick's review:
> - dropped RFC flag
> - rebased atop v2022.07.03
> - simplified test iterator
>   + results stashed at the end of each iteration, rather than start of
>     next / loop-exit
> - dropped aggregate loop stats message from xunit report
> - squashed full/dmesg/out.bad file retention patch with rerun patch
> 
> Changes since (v1):
> - rebased atop upstream v2022.06.26
> - added a few extra cleanup commits
> - append details for every rerun to xunit output
>   + provide aggregate stats via <testcase status=X>
> - extend _stash_test_status to call report hook, as well as save failure
>   artifacts with a .rerun# suffix
> 
> Diffstat:
>  check         | 137 +++++++++++++++++++++++++++++++++++++-------------
>  common/report |  90 ++++++++++++++++-----------------
>  2 files changed, 144 insertions(+), 83 deletions(-)
> 
> 

