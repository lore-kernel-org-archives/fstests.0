Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0D0C54EE9
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 17:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiIVR6w (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 13:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiIVR6i (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 13:58:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF0D106529
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663869515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H9nmCMNAlDh1ZHpjgFRyw9EuODWMN26rLeT1CfWeOxI=;
        b=QTXzEYoyPV+syAXJ632e5d+rRaD7sQs2ioJcRgsIw18LfmBtU9D5TLSgE444ghgWPs6CNC
        58JxLhNAYTMUe/Yd9IvCUk29R24Zia/Hf9DoFIzCQ34xMer+No3BLnL70GZWfB5+62OcHv
        DMVIJJ5lY6QJPOI8V5zZTM58vlJUiic=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-344-iA9hTFJqOfeZG77dtl3VVQ-1; Thu, 22 Sep 2022 13:58:33 -0400
X-MC-Unique: iA9hTFJqOfeZG77dtl3VVQ-1
Received: by mail-qt1-f198.google.com with SMTP id fz10-20020a05622a5a8a00b0035ce18717daso6880726qtb.11
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 10:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=H9nmCMNAlDh1ZHpjgFRyw9EuODWMN26rLeT1CfWeOxI=;
        b=UghYb0Z7hQchjqYMon//5DJ7D+Ofc3cyFwCv2setDvdXRSQFqlhhUemFPeKBIM668T
         QiC/drlFjv6t9rY6BVw7FABAPpAy1E2+GuoLQBiL+bLijTcGDbJlzpyhontFs2rPTVya
         U9KjGX+YAy13Cgveop4OWiBdg2EokyP0EtLig1V+awBkLRV+LlC/G/26/EyaqA3tqVtc
         VJg8M4FVcKf/3N60V61i/XDiRfZMzTu6d1SEawQwecC8Zq1HoZHERxv1p7OZqjVgPdz9
         Hh/oi9oZ7nsFFAsWRq8HPC6BF0rQpVN7zPVIFQcIyIQAZxcrRsiP3WEVwnILShU+Yf8C
         8kJQ==
X-Gm-Message-State: ACrzQf306MdkK9xTelLIEGIJj/RdN/6uGIT3/A68fUw1KnJywrAeJLGy
        YCZR318nuNimfFDpEBQXl1jDUR9WxC1pUXJq22fIPaB5ulfgUi/vIsJCOsvSNCtMqPeiUffd59i
        PYUpI4HCqyYFv7AJT9w==
X-Received: by 2002:a05:620a:4414:b0:6ce:610c:fe34 with SMTP id v20-20020a05620a441400b006ce610cfe34mr3103376qkp.659.1663869513287;
        Thu, 22 Sep 2022 10:58:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5SJxjkkyad5rxwmRmJCZGPAPWXi9PYAhyC+gDmrdo1wfEoVwBRXZzuiOeLOIji7U9Bilvg2A==
X-Received: by 2002:a05:620a:4414:b0:6ce:610c:fe34 with SMTP id v20-20020a05620a441400b006ce610cfe34mr3103359qkp.659.1663869512991;
        Thu, 22 Sep 2022 10:58:32 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i12-20020a05620a404c00b006b8d1914504sm5196751qko.22.2022.09.22.10.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 10:58:32 -0700 (PDT)
Date:   Fri, 23 Sep 2022 01:58:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/4] generic: cleanup test files
Message-ID: <20220922175828.fxsd4kkdzaihruhk@zlang-mailbox>
References: <20220922134822.1020119-1-preichl@redhat.com>
 <20220922134822.1020119-3-preichl@redhat.com>
 <20220922143638.ruwujtwblv43sgfo@zlang-mailbox>
 <079f6725-1f75-24dc-c233-4544c242b30b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <079f6725-1f75-24dc-c233-4544c242b30b@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 22, 2022 at 07:05:57PM +0200, Pavel Reichl wrote:
> 
> > I'm wondering two questions:
> > 1) If these cases all use $TEST_DIR/seek_sanity_testfile, and don't really
> >     remove these seek_sanity_testfile* files, will them affect each testing
> >     result? Can we set BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile_$seq
> >     at least, to avoid they use same files?
> I'm happy to try to implement this idea.

If you need to remove them in cleanup, then the name won't conflict :)

> 

