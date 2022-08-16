Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5366CC25B0E
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Aug 2022 13:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbiHPNIp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 16 Aug 2022 09:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbiHPNIj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Aug 2022 09:08:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3086B3F311
        for <fstests@vger.kernel.org>; Tue, 16 Aug 2022 06:08:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 49104CE1814
        for <fstests@vger.kernel.org>; Tue, 16 Aug 2022 13:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C1BC433D6;
        Tue, 16 Aug 2022 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660655307;
        bh=fHXsELFv9f78ozC1UEoj5gdUnwIhUdxFqYt+7BE6lj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L5miyZ3LMhi0EuxXO8DlHf4QHvfvIVLmvXCB+KClqWyTSDTx9w21zlpmX4u0AMrgZ
         vZs5MWuPmy4MduE+yOuDcoGhvDsk9q+oNDEbd1UpGrnn8wQE6iTbuK5aWhruqHey+g
         NaqRjQ0yOHdy2rsI3oo3V2+nS53Frkf0LLkt99QVBcTX8RMC4HjT+EgAiLLDTnNrBS
         0udx/is6iCvXx/B66feA9VdPs574Kj4wf+e0liaDdWJdhtpJzRMxIF1UGMi6kgKVjg
         hd+VpLXcF5jlax3resHOAY0QNhcN5vhrjSq6D3hYq3fJafqDceIn6GYQ1cMzR/Bw40
         doBFh88OUp6DA==
Date:   Tue, 16 Aug 2022 15:08:23 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Su Yue <glass@fydeos.io>
Cc:     fstests@vger.kernel.org, l@damenly.su, sforshee@kernel.org
Subject: Re: [PATCH] vfs/idmapped-mounts: fix unhandled EOVERFLOW in
 setattr_fix_968219708108
Message-ID: <20220816130823.3a43ilcl2v74uyad@wittgenstein>
References: <20220816121551.88407-1-glass@fydeos.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220816121551.88407-1-glass@fydeos.io>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 16, 2022 at 08:15:51PM +0800, Su Yue wrote:
> Since kernel commit b27c82e12965 ("attr: port attribute changes to new
> types"), errno should be EOVERFLOW instead of EINVAL if fchownat(2)
> called with {g,u}id whose mapping are not in fs/mount idmappings.
> 
> The errno EOVERFLOW causes failure of generic/656:
> ========================================================================
> generic/656 3s ... [failed, exit status 1]- output mismatch (see /root/xfstests-dev/results//generic/656.out.bad)
>     --- tests/generic/656.out   2022-01-03 14:18:41.049999153 +0800
>     +++ /root/xfstests-dev/results//generic/656.out.bad 2022-08-16 20:09:41.679999992 +0800
>     @@ -1,2 +1,4 @@
>      QA output created by 656
>      Silence is golden
>     +idmapped-mounts.c: 7371: setattr_fix_968219708108 - Value too large for defined data type - failure: errno
>     +vfstest.c: 1882: run_test - Success - failure: test that setattr works correctly
>     ...
>     (Run 'diff -u /root/xfstests-dev/tests/generic/656.out /root/xfstests-dev/results//generic/656.out.bad'  to see the entire diff)
> Ran: generic/656
> Failures: generic/656
> ========================================================================
> 
> As Christian Brauner explained:
> "
> - EINVAL should only be reported because the target {g,u}id_t has no
>   mapping in the caller's idmapping, i.e. doesn't yield a valid k{g,u}id_t.
> - EOVERFLOW should be reported because the target k{g,u}id_t doesn't
>   have a mapping in the filesystem idmapping or mount idmapping. IOW,
>   the filesystem cannot represent the intended value. The mount's
>   idmapping is on a par with the filesystem idmapping and thus a failure
>   to represent a vfs{g,u}id_t in the filesystem should yield EOVERFLOW.
> "
> 
> EOVERFLOW is another reasonable errno so handle it after fchownat(2)
> failed.
> 
> Link:https://lore.kernel.org/fstests/20220816103040.gtgg2w75tzpejas5@wittgenstein/T/#t
> Signed-off-by: Su Yue <glass@fydeos.io>
> ---

Looks good,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
