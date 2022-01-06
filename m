Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D94C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Jan 2022 16:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241428AbiAFQu5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Jan 2022 11:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241433AbiAFQux (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Jan 2022 11:50:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6387C061245
        for <fstests@vger.kernel.org>; Thu,  6 Jan 2022 08:50:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4511E61D16
        for <fstests@vger.kernel.org>; Thu,  6 Jan 2022 16:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F982C36AEB;
        Thu,  6 Jan 2022 16:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641487849;
        bh=DiPlFEuh3ztfFnIfJA6caqEjQwM1+7fA8snoen45QMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EnuqA3PNjlXMQiVjX1DA/yMy2wIqJy3k+Wp95X6/YQ+bqYCusCBRB25xsg4+MVjv0
         Uwdzf+thpLb7mdyO5zxdpgkTiULe0Z+1szBTFYx+5Wo5RN3z3BS/b8OViZUtlgz5hN
         V8rtB0VykMXKbYCIROtQZXXlOIQbVocvpu9vDTFd/xJjObSsundshqADu/tavU4z9V
         +dG+ZSu4GLD2EG/h1FPrHcJ6P4emDcX5NE455HFW3Ezu2fMJYKZjsMhcv+SzmSA8LE
         iyIhch/GvNWz4xGkrwm00fUcvUv7ZlCFQn+WcP2M6usVuovtyNoTCsAymiaxSl0Rn1
         cqxBz5n1tQ7tQ==
Date:   Thu, 6 Jan 2022 08:50:48 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, guan@eryu.me,
        Luis Henriques <lhenriques@suse.de>
Subject: Re: [PATCH v2] common/rc, ceph: skip ceph/001-ceph/003 if
 test_dummy_encryption is enabled
Message-ID: <Ydcd6OsuEzx9HtQx@sol.localdomain>
References: <20220106133049.68171-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106133049.68171-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 06, 2022 at 08:30:49AM -0500, Jeff Layton wrote:
> Some tests on ceph require changing the layout of new files, which is
> forbidden when the files are encrypted. Skip these tests if the
> test_dummy_encryption mount option is being used.
> 
> Generalize the _exclude_scratch_mount_option code and add a new
> _exclude_test_mount_option call as well. Call the new function from the
> ceph tests that should exclude test_dummy_encryption.
> 
> Cc: Luis Henriques <lhenriques@suse.de>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  common/btrfs   |  2 +-
>  common/rc      | 28 +++++++++++++++++++---------
>  tests/ceph/001 |  1 +
>  tests/ceph/002 |  1 +
>  tests/ceph/003 |  1 +
>  5 files changed, 23 insertions(+), 10 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
