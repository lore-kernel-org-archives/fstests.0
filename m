Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A841AC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jun 2022 15:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbiFPPZQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Jun 2022 11:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376854AbiFPPZP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Jun 2022 11:25:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B80A3616A
        for <fstests@vger.kernel.org>; Thu, 16 Jun 2022 08:25:14 -0700 (PDT)
Received: from localhost (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: krisman)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3009F6601741;
        Thu, 16 Jun 2022 16:25:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655393113;
        bh=hoCtnetxD3Bf0fdXAzu+X/27sNxI2d4H4AK7opw67y4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ScK5UIpPixi5MqvrwBUsIcNjb/sJQgH7iKYNWw2JKCvjYCSZQ0/lTBNHF3o6HKM3P
         TNnHMCXvP+fAm4n6S0w2cDsYpmqs3UQJLrnqAzWNDxi4L29jLt6/WtL6JGvUit2b4g
         91Si7M9DXo6ckB/AjyJFOGjYYZQGzTErTTCVZYonh24ZhECDY+FPyfAOp+2bfLioAj
         aj4U+ZVPQ0I3+3URkg1cOWpIWW9vTJiyQYUwZtf5RZSlMfS8JeDKq2RtTPGvDrCX2R
         d4N6zwdTMwBSTzr1TBMzqoPPrqNJkF+D/9tVYZ3O88BscJ6sqB4Ux6Gm5PKIiPhFBd
         DLyaA1qIhUkwQ==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     An Long <lan@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/2] common/rc: add _parse_size_string
Organization: Collabora
References: <20220616043845.14320-1-lan@suse.com>
        <20220616043845.14320-2-lan@suse.com>
Date:   Thu, 16 Jun 2022 11:25:09 -0400
In-Reply-To: <20220616043845.14320-2-lan@suse.com> (An Long's message of "Thu,
        16 Jun 2022 12:38:44 +0800")
Message-ID: <874k0ky6ju.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

An Long <lan@suse.com> writes:

> +        if [[ $str =~ ^[0-9]+[a-zA-Z]$ ]] ; then
> +                size=${str:: -1}
> +                endchar=${str: -1}
> +                case $endchar in
> +                e|E)
> +                                mult=$((mult * 1024))
> +                                ;&
> +                p|P)
> +                                mult=$((mult * 1024))
> +                                ;&
> +                t|T)
> +                                mult=$((mult * 1024))
> +                                ;&
> +                g|G)
> +                                mult=$((mult * 1024))
> +                                ;&
> +                m|M)
> +                                mult=$((mult * 1024))
> +                                ;&
> +                k|K)
> +                                mult=$((mult * 1024))
> +                                ;&
> +                b|B)
> +                                ;;
> +                *)
> +                                echo "unknown size descriptor $endchar"
> +                                exit 1
> +                esac
> +        elif [[ $str =~ ^[0-9]+$ ]] ; then
> +                size=$str
> +        else
> +                echo "size value $str is invalid"
> +                exit 1
> +        fi
> +
> +        size=$((size * mult))
> +        echo $size
> +}

Hi An,

Coreutils has numfmt(1) to do this kind of conversion.  I wonder if we
could use it here, unless it is not available all the platforms that
matters for xfstests, though:

$ echo 1K | numfmt --from=iec
1024

> +
>  # Create fs of certain size on scratch device
>  # _scratch_mkfs_sized <size in bytes> [optional blocksize]
>  _scratch_mkfs_sized()

-- 
Gabriel Krisman Bertazi
