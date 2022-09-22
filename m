Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6166BC6FA82
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 14:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIVOvm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiIVOvl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 10:51:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01D1B4EA4
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663858300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XSk/DWRSy/GS2SIOi8E6oxMhtqm8mRRgbvtePvh2siU=;
        b=YndThBXYgjpleiK9QJvB18k8PRjlrresGQXwSmaDDKIkOoD60tl36iIF6rZlmo6uokwmbs
        BGZrbLJ6U134oaeVH/I/OqrogdCfIhJHrQDjqo3afBt4+gI1DHltXMk8LrlVe6HwhWW9a+
        WVRJQhg23MJGH+RAPqhEyslx1HgjW/U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-326-H2PcDLaBOdShi62eCAMJag-1; Thu, 22 Sep 2022 10:51:38 -0400
X-MC-Unique: H2PcDLaBOdShi62eCAMJag-1
Received: by mail-ej1-f69.google.com with SMTP id oz30-20020a1709077d9e00b0077239b6a915so4635621ejc.11
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 07:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XSk/DWRSy/GS2SIOi8E6oxMhtqm8mRRgbvtePvh2siU=;
        b=cmXHDrQsO7QyO3Fb/lWbfO7Dt/xVd3UeixU7QawrUEendtrLFeopWFvTsaOk+gacgW
         fFcacHJxMzmW6YD1zGIW/OiCzjkxMdPu+9XsGrZZYL59rXNsiSs2wwQeg+A8w7CIxDfR
         XvfuRyMacBe4YmPKU0KAyj4Jz9q6ctp4Ykk0CQIODAfRyLh+AHeH8rmth73gXb7fyoWI
         72GuHrbytoQuQn7BbNTj2rO4XDLqRuu53B42kbl0LAXQfTJ6bfAvXog2UNXLvfmK3eAp
         YwFk6/kzlo0OvYibdB5zS1j7i0XXhdDizmTAbtBOl6tqwA/OrTLye3xoXZjvRSHqyDkN
         LfeA==
X-Gm-Message-State: ACrzQf3Ki5uPNSuTeZgW0iSD9XoaZEZodk1QOPViYlfjiQHrHPecWqhO
        sp+45D1WzntTrEsr6+QIVbcgQfpUN7TttmtJcGXdIJ8j3xtJhg4X8/p2TJ/SP1JcfaYwvDB+w/W
        zTr4Thpe0Ch3EslZeTQ==
X-Received: by 2002:a17:907:6ea3:b0:77c:4e23:9b2d with SMTP id sh35-20020a1709076ea300b0077c4e239b2dmr3207327ejc.6.1663858297242;
        Thu, 22 Sep 2022 07:51:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM68z/8OdOG/Yy/6zFSVfh4lbAodXFL9lgCa/4kQTd//ZzK+7+uJ/+trkNEd9wP9y0iZ+kbGGA==
X-Received: by 2002:a17:907:6ea3:b0:77c:4e23:9b2d with SMTP id sh35-20020a1709076ea300b0077c4e239b2dmr3207313ejc.6.1663858297055;
        Thu, 22 Sep 2022 07:51:37 -0700 (PDT)
Received: from [192.168.100.69] (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id ky6-20020a170907778600b00778e3e2830esm2780877ejc.9.2022.09.22.07.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 07:51:36 -0700 (PDT)
Message-ID: <eaa803b6-9552-b7da-31a7-fb86af18c8f1@redhat.com>
Date:   Thu, 22 Sep 2022 16:51:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/4] common: Fix file leak in _get_max_file_size
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
References: <20220922134822.1020119-1-preichl@redhat.com>
 <20220922144606.6nx5figsoe6j7wrz@zlang-mailbox>
From:   Pavel Reichl <preichl@redhat.com>
In-Reply-To: <20220922144606.6nx5figsoe6j7wrz@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


>>   
>> diff --git a/tests/generic/692 b/tests/generic/692
>> old mode 100644
>> new mode 100755
> Hmm... is this another fix? Although I don't know if it's worth to be a single
> patch, if it doesn't cause anything wrong?
Hmm, sorry about this change, it's not on purpose, I'm not sure what 
happened here. I'll remove it in the next iteration

