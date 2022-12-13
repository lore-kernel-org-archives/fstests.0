Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B4BC4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 13 Dec 2022 14:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiLMOmu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 13 Dec 2022 09:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbiLMOmq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Dec 2022 09:42:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B8311E
        for <fstests@vger.kernel.org>; Tue, 13 Dec 2022 06:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670942520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Agc7h/iEyfltGfFmPl1XJRnvcC1rNnMEdSgcDmzlgHY=;
        b=VnDi4NM/3jIizfAccMPk6tCURJqHq+dGBW0puzJma/tSw5yNQLqHLQlcD/CqP7Gk+WLfv2
        vHuyXWMBeSRB+C1cBltavvRlWn3sp/Myc28oeDUqCn3nkLMgsyoRKA9aQ6ubkt5a6eowCu
        n1t2buBZgbSUxO/AlC68GLiRXTG1Zjg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-609-O8VE2wuyOJyMTFForaFfjQ-1; Tue, 13 Dec 2022 09:41:59 -0500
X-MC-Unique: O8VE2wuyOJyMTFForaFfjQ-1
Received: by mail-pg1-f200.google.com with SMTP id p7-20020a631e47000000b0047691854a86so9809899pgm.16
        for <fstests@vger.kernel.org>; Tue, 13 Dec 2022 06:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Agc7h/iEyfltGfFmPl1XJRnvcC1rNnMEdSgcDmzlgHY=;
        b=Q9tLQJUNAcuX6FvDoJ16nen70FPMhPRul3GL2d7nYtzgLtg3OGyb/4EqyaX0lagKEB
         Pkeiuy53QW/yNuujdfC6s17Q/W3N2+PTUhWLJlsH41Ri7B0neNqvr0i0iiJwtrYGk2xU
         Vt7ecxMoSH88YKQ3n76/sprPEHJkONxFQ7eO3HZ1aIq4/BGIA3AiuVcqzA7+/1/p5Y4L
         SYLUv/COTgkj3XrumITJTRwyNSvke4Rw4e3GP6rb6glshbCIw0xKuUfW0PuR7NFn2a8Q
         /l/XrtcKGg4fs31rhHV1wHAjmBapHbQNTahBmnyFYox/pfHNIIl795go8P0tvHR2/Ly3
         CTJg==
X-Gm-Message-State: ANoB5pmcCesmmSGcmZCNwWpVoYjTonhxrM8o2AtnpcEhPqnmtwBBNHHK
        fwootiY8rS7Ob9DlrWhq1KfgfIQ+IbLDrnEHZ0oM6MwtQWQMshQUm7q6owexywI2ys+MBOFB97G
        9gyWH/vFaKGfu7dJhiw==
X-Received: by 2002:a17:902:7c90:b0:186:f257:8df with SMTP id y16-20020a1709027c9000b00186f25708dfmr18434184pll.42.1670942518187;
        Tue, 13 Dec 2022 06:41:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7jAwgeFjPKtQuyv01mXyT7Hbu0iPJsE0NnYfitnt770bovgB72u3Z9gMf51ZsgEAE/a/SXlA==
X-Received: by 2002:a17:902:7c90:b0:186:f257:8df with SMTP id y16-20020a1709027c9000b00186f25708dfmr18434165pll.42.1670942517798;
        Tue, 13 Dec 2022 06:41:57 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w11-20020a170902ca0b00b0018930dbc560sm8561099pld.96.2022.12.13.06.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 06:41:57 -0800 (PST)
Date:   Tue, 13 Dec 2022 22:41:52 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 1/3] common/attr: require xfs_spaceman for xfs acl_get_max
Message-ID: <20221213144152.ae7oqrhtecuqwgya@zlang-mailbox>
References: <20221212230820.3466-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212230820.3466-1-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Dec 13, 2022 at 12:08:18AM +0100, David Disseldorp wrote:
> For xfs, _acl_get_max() calls xfs_info which in turn calls
> "xfs_spaceman -c info ...".
> 
> Without this change, xfs_spaceman absence results in:
> --- tests/generic/026.out
> +++ /home/david/xfstests/results//generic/026.out.bad
> @@ -1,9 +1,11 @@
>  QA output created by 026
> +/usr/sbin/xfs_info: line 44: xfs_spaceman: command not found

Hmm.. That's weird, both xfs_info and xfs_spaceman are from xfsprogs
package. If someone xfsprogs version doesn't hasve provide xfs_spaceman,
why its xfs_info would like to call that? What xfsprogs do you use?

Thanks,
Zorro

> 
>  === Test out large ACLs  ===
> +/usr/sbin/xfs_info: line 44: xfs_spaceman: command not found
>  1 below acl max
>  acl max
> ...
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  common/attr | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/attr b/common/attr
> index cce4d1b2..a94c5e4b 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -57,6 +57,9 @@ _acl_get_max()
>  
>  _require_acl_get_max()
>  {
> +	# _acl_get_max -> xfs_info -> xfs_spaceman
> +	[ "$FSTYP" == "xfs" ] && _require_xfs_spaceman_command "info"
> +
>  	if [ $(_acl_get_max) -eq 0 ]; then
>  		_notrun "$FSTYP does not define maximum ACL count"
>  	fi
> -- 
> 2.35.3
> 

