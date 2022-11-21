Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F383C433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Nov 2022 13:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiKUNdP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Nov 2022 08:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiKUNdF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Nov 2022 08:33:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BEAC285D
        for <fstests@vger.kernel.org>; Mon, 21 Nov 2022 05:33:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCF1FB80F1A
        for <fstests@vger.kernel.org>; Mon, 21 Nov 2022 13:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C819C433C1
        for <fstests@vger.kernel.org>; Mon, 21 Nov 2022 13:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669037579;
        bh=WF9wRcFYZq0AFpUuRJFUXp3XQdJkZZFTHug+Wt68+sY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KKk0mI7k87FWzPtDisjhL3jTCJFr7pqAQWUrDQ1AtClurdJnOU0R+XVbWeX3z/vGP
         QbyATVEgNwAp1VD1TouM1cbzTzfCd4tKBedfZgUNY6/tNEYktf8ndV5ju3ZbYJ/98+
         hftvWCakYtEHB0FbDeYQIp9HGyyIUA6gbTt5oqVTrO0R7hh+zoreY2Z224V9Ce8eHf
         Ee+N5UiE7kyx1lnuTOu93lMw95ZFy4eta7voC8NGZ6xtVYF2UK3E3ZPggGB6R/N32p
         Lwt9/uWvHPYJ960mZ7gjsHRF7mAOyNYplmv+Qz25FitdQl7qS7U3XIAFg16qq5bKvW
         b8x81vo++BypQ==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-142612a5454so13052214fac.2
        for <fstests@vger.kernel.org>; Mon, 21 Nov 2022 05:32:59 -0800 (PST)
X-Gm-Message-State: ANoB5pk6LsqVnvTDRVA7TOc30lwBs2UVyIzbFXeEcSY13WebHEKsMYUL
        ZCUNQtLI4b+eJRGnS9eledkvqaDIRzhOtFO3+Ws=
X-Google-Smtp-Source: AA0mqf5ecT1kBkrMVqSe1GOIvpu3BL22PwJWk8mRd8ieCmUk3YvFKGVVbwAqvFGdepJLDgOk646YP/6+PQXWYtuL2UM=
X-Received: by 2002:a05:6870:cc89:b0:12b:fbe7:b793 with SMTP id
 ot9-20020a056870cc8900b0012bfbe7b793mr12701272oab.92.1669037578747; Mon, 21
 Nov 2022 05:32:58 -0800 (PST)
MIME-Version: 1.0
References: <20221121123636.ltwwxgoom5bd4eyd@quack3>
In-Reply-To: <20221121123636.ltwwxgoom5bd4eyd@quack3>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 21 Nov 2022 13:32:22 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5fCW9ViD3R8pX9ekLrtF-NpaqaEX+SjmVH09jRsT53dQ@mail.gmail.com>
Message-ID: <CAL3q7H5fCW9ViD3R8pX9ekLrtF-NpaqaEX+SjmVH09jRsT53dQ@mail.gmail.com>
Subject: Re: Test generic/614
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 21, 2022 at 12:37 PM Jan Kara <jack@suse.cz> wrote:
>
> Hello Filipe!

Hi Jan!

>
> I have noticed test generic/614 is failing on ext2. The test creates sparse
> file, maps it, and writes data to it through mmap. Then it checks i_blocks
> has increased. However for ext2 (and other trivial filesystems supporting
> sparse files but not implementing delayed allocation) this is bound to fail
> because i_block gets incremented only during page writeback.
>
> So would your btrfs test make sense even if we called fsync(2) before
> checking stat(2) results?

Calling fsync before calling stat would defeat the purpose of the test.
I.e. the test would pass both with and without the btrfs fix.

So maybe adding the following to the test:

_supported_fs ^ext2

And listing all other filesystems not supporting delayed allocation?

Or adding a _require_delayed_allocation() helper to make it _notrun().

Thanks.



>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
