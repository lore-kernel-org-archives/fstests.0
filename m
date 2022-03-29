Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4503FC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Mar 2022 11:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiC2LhO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 29 Mar 2022 07:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiC2LhN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Mar 2022 07:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B28D24F34
        for <fstests@vger.kernel.org>; Tue, 29 Mar 2022 04:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648553729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fXnHPC+OiAPJne+tGozvsjs7kjdnSbS+ytsK3cyFZ6I=;
        b=Q38OFR+yxiOgBtwK0MYxq+XNPz+ZWzg79Ii33X9DniI7BlwolZfSeRa5jK+abhtgMj7kCK
        seNAxDiBVzp/1rSsktox7CMyQWoNUNMN0tbkahaZjobFoMCZJVIVj9IQKzpzdyp8EddXWl
        7Y5V3T2jJmYjodD4mzlyh9pOq1A4PSk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-fyi2BSXEP2iyo5FUcdrWlg-1; Tue, 29 Mar 2022 07:35:27 -0400
X-MC-Unique: fyi2BSXEP2iyo5FUcdrWlg-1
Received: by mail-pl1-f200.google.com with SMTP id n12-20020a1709026a8c00b001538f557d52so7483292plk.2
        for <fstests@vger.kernel.org>; Tue, 29 Mar 2022 04:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=fXnHPC+OiAPJne+tGozvsjs7kjdnSbS+ytsK3cyFZ6I=;
        b=rgvyVt8c3hdlSP3XBu6QqEbOsi+xnxBJX/BRel2xsekxVK56vqDi5hKaNjhTHjWr90
         sDwTg+sLW72tVwvTjO0lWU/kf/y2FjwIxcmRLLsI1Hq1bEbLdU2N2CaEnRski9gLpU6e
         mTebUa8tZTaWjZ+cv/QDlZcCP94w500GEOWUeIxG+OFuZk3EMIGTUxMD+bVDjzU+MrO0
         KTkepkuAM7VcZFI0jXw3c0bpZiZOMTpFJsrV1P6hxmQ9I6vBplpfnGUB4hWD1WBQYfG+
         JZZye699yXNpcTX80YBzNHXCyKX5G9nR0h2jEcp8iZ5TOeqhRoPLsQhKcSGUp4BkK27F
         2bTA==
X-Gm-Message-State: AOAM533IvIzrkFp4QyaWg9NtG+kfQeAUjOmQXzKyLTgJc44okyelZInF
        S2/5WkfUD402l1E9XZFhP9eLeq6OZxWeAp0BTJaJHJw+QRpgcLR1hAiCxbpijM6bBVSPIFrlqTc
        cJgSSq1UcaCArilDR2Q==
X-Received: by 2002:a17:902:f60f:b0:151:4f66:55b4 with SMTP id n15-20020a170902f60f00b001514f6655b4mr30260824plg.127.1648553726760;
        Tue, 29 Mar 2022 04:35:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGIGN1kc+AvF47Zmrdit0XSRKlJyqSob62Po8PI4qDXOkVyGrYZGOIGqZWX3a6aYlU5BlfUw==
X-Received: by 2002:a17:902:f60f:b0:151:4f66:55b4 with SMTP id n15-20020a170902f60f00b001514f6655b4mr30260809plg.127.1648553726370;
        Tue, 29 Mar 2022 04:35:26 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o3-20020a056a0015c300b004fb24adc4b8sm13179711pfu.159.2022.03.29.04.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:35:25 -0700 (PDT)
Date:   Tue, 29 Mar 2022 19:35:21 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "liuyd.fnst@fujitsu.com" <liuyd.fnst@fujitsu.com>
Subject: Re: [Question] About allocsp_calls not implemented
Message-ID: <20220329113521.56ks64wanu5kreur@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "liuyd.fnst@fujitsu.com" <liuyd.fnst@fujitsu.com>
References: <1b0b8627-0d30-018b-4a98-b69f5a8033f1@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b0b8627-0d30-018b-4a98-b69f5a8033f1@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 29, 2022 at 09:59:02AM +0000, liuyd.fnst@fujitsu.com wrote:
> Hi, all.
> 
> We noticed below tests failed due to fsx issue introduced by a32fb1bb 
> fsx: add support for XFS_IOC_ALLOCSP.
> 
> generic/075  generic/091  generic/112  generic/127  generic/263
> 
> The log shows "do_allocsp: allocsp: Function not implemented".

Hmm... Darrick, I think we'd better to disable IOC_ALLOCSP operation
in fsx.c by default, and use another option to allow user to enable it
if they need. Or use another option to disable it, leave -F for fallocate
only.

What do you think?

Thanks,
Zorro

> 
> 
> The error has been around for a while so I want to know whether upstream 
> has got this info. As of now, we revert cd99a499 and a32fb1bb to test.
> 
> -- 
> Best Regards.
> Yiding Liu

