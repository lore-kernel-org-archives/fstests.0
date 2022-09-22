Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3E1C6FA82
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 17:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiIVRGL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 13:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiIVRGJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 13:06:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABD8EFF65
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663866363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYBCzs2HdGuBI4TE4Bwk+GDshLhLpVGYJVY55KDlNH4=;
        b=Xw7ltyA/84c13GSL0wjEvNLjJ+aRxgyuyFSmFVWrfopZ1vp6w46QoPsR9s6nMMA0HpEUii
        k4zE3Kafu45FI6zuSWe+YrkPuJcjQhFytxkD8ytubzTe7gZ5UtP0UGKHnsDqj9oJ5utVvX
        G3ZX81DuW7CkYixfjOs8oPLO1w6j0kc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-265-CVB7oPF5PRuH1jUwKzy4Jw-1; Thu, 22 Sep 2022 13:06:02 -0400
X-MC-Unique: CVB7oPF5PRuH1jUwKzy4Jw-1
Received: by mail-ej1-f69.google.com with SMTP id sh31-20020a1709076e9f00b00781c4e720feso4371485ejc.8
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 10:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QYBCzs2HdGuBI4TE4Bwk+GDshLhLpVGYJVY55KDlNH4=;
        b=OaYCyfyWRq5SfYOLy8Gxkj35q6sICwVHsZfEDn3TMZ8Uim8fsewNmxosKtDOyMm2xn
         5hSedbnL2TQ+GzN3RoQU1QSD55m1bGhMRH3rdEWGJC97qclZj5SuIvXGE4glzRMaPPyG
         K5n7KXzu7MdmqNWGtbhDCFf2I+L0aPaRQj94oWbpn8iue/YCTVzkEmSPOx+b20Y9lGO2
         upFn/y7q6ulOyOZi2rpqELhtQo9836G4SFSeJAE4WsmofsnbEp8JKrNUuS7UwHLp2wU4
         8XE0ZeDenpeIcMgIBrV+sn8MV77jO0MBxWR7iiP49jXy2y4Dg32JSD3Z3Sye2gxwxaXI
         o74g==
X-Gm-Message-State: ACrzQf2V0LWh0VW59tm57Q5EyamA03PgUaC2a8YW9KD+/ORvw/ebn693
        YrauUBm+YVaxZ1WwcBMIA2TMJUzBGd5Y7lafGbgc/wmojjGvlWQUdAoXqlJckM/s8XSsqYKlU4H
        GWStG2oadCW+cjJcmvw==
X-Received: by 2002:aa7:c050:0:b0:453:4427:a947 with SMTP id k16-20020aa7c050000000b004534427a947mr4326588edo.172.1663866359907;
        Thu, 22 Sep 2022 10:05:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7ByZOnohW87zPH7og7WEisAk7kYE5PyQr/2gdQIZlSTqpCxCDLf0sCSXwSgFmknfzRwZNFLA==
X-Received: by 2002:aa7:c050:0:b0:453:4427:a947 with SMTP id k16-20020aa7c050000000b004534427a947mr4326577edo.172.1663866359747;
        Thu, 22 Sep 2022 10:05:59 -0700 (PDT)
Received: from [192.168.100.69] (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id r3-20020aa7d583000000b004539604cc9esm3890944edq.96.2022.09.22.10.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 10:05:58 -0700 (PDT)
Message-ID: <079f6725-1f75-24dc-c233-4544c242b30b@redhat.com>
Date:   Thu, 22 Sep 2022 19:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 3/4] generic: cleanup test files
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
References: <20220922134822.1020119-1-preichl@redhat.com>
 <20220922134822.1020119-3-preichl@redhat.com>
 <20220922143638.ruwujtwblv43sgfo@zlang-mailbox>
From:   Pavel Reichl <preichl@redhat.com>
In-Reply-To: <20220922143638.ruwujtwblv43sgfo@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


> I'm wondering two questions:
> 1) If these cases all use $TEST_DIR/seek_sanity_testfile, and don't really
>     remove these seek_sanity_testfile* files, will them affect each testing
>     result? Can we set BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile_$seq
>     at least, to avoid they use same files?
I'm happy to try to implement this idea.

