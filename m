Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF1BC00140
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Aug 2022 09:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiHBJRH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 2 Aug 2022 05:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiHBJRG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 2 Aug 2022 05:17:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA31432D97
        for <fstests@vger.kernel.org>; Tue,  2 Aug 2022 02:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B73560EA1
        for <fstests@vger.kernel.org>; Tue,  2 Aug 2022 09:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9F2C433C1;
        Tue,  2 Aug 2022 09:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659431824;
        bh=jR6BJdLSokcjh7oUmAP270RbjzyuS947hQRJjvd+FRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vdr2DNVhN+YtjyACVmHgAF2DG+aQOlpuAf8tBo84G+/y5IUGHFGus1wf/KHyupm6B
         QejCpHdMhOaCiac57r0Qs+DsGSMVqWJdm6Y3KidIyMEEp9gj/MBMMPqVe1YarQ7Glp
         NPtojbI5iolz9xqzl2Tqkqv7DRJB7dh6EXGp6R532zVdL1VqkV0xcnsNWVAZcgGBw3
         Plgc/dnrSKwnZkT5/WOOYtzsF1FmO2bWzaSYDKub25zTbvSQBlNTVmzWUFdaBkPvwx
         sr3m8lXqmUl1zpQml0kRN3jQJDDNKCqZ/l59QWVe6KxnPZp40d9QJED2qleGnVeScm
         6E+uMZkX9yyZw==
Date:   Tue, 2 Aug 2022 17:17:00 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Liu Yiding <liuyd.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH] generic/688: Skip test if fs doesn't support security
Message-ID: <20220802091700.d2e3u7defue7kwbd@zlang-mailbox>
References: <1659426760-2-1-git-send-email-liuyd.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659426760-2-1-git-send-email-liuyd.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 02, 2022 at 07:52:40AM +0000, Liu Yiding wrote:
> This test require security attr. Skip test if fs doesn't support
> security attr. E.g. virtiofs
> 
> Signed-off-by: Liu Yiding <liuyd.fnst@fujitsu.com>
> ---

Hmm... looks like we can re-start this discussion long time ago:

https://lore.kernel.org/fstests/20220323023845.saj5en74km7aibdx@zlang-mailbox/

About how can we deal with those fs doesn't support capabilities, e.g. nfs, virtiofs??

Thanks,
Zorro

>  tests/generic/688 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/generic/688 b/tests/generic/688
> index 426286b6..d11b4c21 100755
> --- a/tests/generic/688
> +++ b/tests/generic/688
> @@ -7,6 +7,7 @@
>  # Functional test for dropping capability bits as part of an fallocate.
>  #
>  . ./common/preamble
> +. ./common/attr
>  _begin_fstest auto prealloc quick
>  
>  # Override the default cleanup function.
> @@ -28,6 +29,7 @@ _require_command "$GETCAP_PROG" getcap
>  _require_command "$SETCAP_PROG" setcap
>  _require_xfs_io_command falloc
>  _require_test
> +_require_attrs security
>  _require_congruent_file_oplen $TEST_DIR 65536
>  
>  junk_dir=$TEST_DIR/$seq
> -- 
> 2.34.1
> 
