Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A02EB64DA
	for <linux-fstests@archiver.kernel.org>; Wed, 28 Jun 2023 11:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjF1LS2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 28 Jun 2023 07:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231648AbjF1LR7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Jun 2023 07:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687951029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQ+SfBYofYyo4npYzn+5YW18gckQ4DOQU8JMKeMG+FQ=;
        b=CZfM2Lm8v8gi0T+Coz3UpNawo5U1T2VJERAbbdFnnlPUW1a3HNMPl2r6URIaVvBuqeGcmP
        He3ZzvZortWrB2IYD2yoqXDK/L3lUFXFVEpNaBg/Y4XsljcVFqBspFfwuFSYISMsDPe3xJ
        mbK/Za2ntYR76AMK0tDjeCnjsH8JrcM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-J66YujZbNRmdJmk6B-DZWw-1; Wed, 28 Jun 2023 07:17:07 -0400
X-MC-Unique: J66YujZbNRmdJmk6B-DZWw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-66870a96b89so2610262b3a.3
        for <fstests@vger.kernel.org>; Wed, 28 Jun 2023 04:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687951026; x=1690543026;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQ+SfBYofYyo4npYzn+5YW18gckQ4DOQU8JMKeMG+FQ=;
        b=FBi1aAlgtWPELFYnHwU+kEDspUH4YRooQbxW9xZEA4RRXnNhEAjSPluRTJS90BijX1
         Ik/5tjhUE5lO7VRslIjreVA6u9ljJuHRqNzf35HbCQkK9Wb09umyViaKqLTpvSjCAk/e
         SvXYuCSZiz72WRMqmTp0+rgcBWhzJ2KmQ5XtRNrQH3eX01fZzaRD4Yr7BVBjacqnNbE8
         9TDq3u3TfR7dD25A9NEkBW/1LfS69C+lo5n8bvaFCsU+RdZFqxQzKA0XPyQWvs3kBmhU
         yyRc6jaUpZm3Sh6D6Jh54am6PC5D1Xx0dtt250sqloam6rCfnvvQ8cgWHfanZo7FlLTH
         K+2g==
X-Gm-Message-State: AC+VfDxtj/0hQOuJQyaa6Dx1I+VsClF0AXtrvMvut/vq8YonAl8WY16k
        IzdWQ1x+Bc/fpeZf1B4nV7OYxhMXQ0g4TdH5CGAdxNL2JPXbDOMDmyIQ1K7XgjS/xGRagewvQsi
        3v301qsogUTN88+l8TMmA+doVQQah
X-Received: by 2002:a05:6a21:3806:b0:126:a5e3:3927 with SMTP id yi6-20020a056a21380600b00126a5e33927mr5762369pzb.8.1687951025906;
        Wed, 28 Jun 2023 04:17:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60505zzfTCBG58CeeMrTCT+6VLHPDxfoG52kOTimRMs99DWpwR2T+uGId5Cp98lJE476X2KA==
X-Received: by 2002:a05:6a21:3806:b0:126:a5e3:3927 with SMTP id yi6-20020a056a21380600b00126a5e33927mr5762358pzb.8.1687951025597;
        Wed, 28 Jun 2023 04:17:05 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m12-20020aa78a0c000000b00679d3fb2f92sm4162919pfa.154.2023.06.28.04.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:17:05 -0700 (PDT)
Date:   Wed, 28 Jun 2023 19:17:01 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     stsp <stsp2@yandex.ru>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] support busybox modprobe
Message-ID: <20230628111701.3ucgo3fz37olhrkc@zlang-mailbox>
References: <20230627182731.3428042-1-stsp2@yandex.ru>
 <20230628085241.olv63wqya2tcej6o@zlang-mailbox>
 <d39417c2-30ab-18ae-2f04-6d2c86007df6@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d39417c2-30ab-18ae-2f04-6d2c86007df6@yandex.ru>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 28, 2023 at 03:25:05PM +0500, stsp wrote:
> 
> 28.06.2023 13:52, Zorro Lang пишет:
> > On Tue, Jun 27, 2023 at 11:27:31PM +0500, Stas Sergeev wrote:
> > > This modprobe writes help to stderr.
> > > We need to redirect it to stdout, or it will end up in a test results.
> > Which modprobe version writes help to stderr, can you show more details?
> As I said already, its a busybox modprobe.
> BusyBox v1.36.0.

OK, looks like this change won't affect anything else, so it's good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 

