Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C667C4743C
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Jun 2021 17:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243EC6115B
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Jun 2021 17:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhFURkO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230503AbhFURkO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 Jun 2021 13:40:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D752D6115A;
        Mon, 21 Jun 2021 17:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624297080;
        bh=xxVSzkqSbcyxzZZkuT8KBiv4xGpatbam7HYXXy6hb0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rqVRMx2Ikb3qSHon5wt4EwapMOnYUxrdEXP7sYXDHgbv/y/SmDWWFesVyEQ/EM01H
         bQeEh5jQ0t/f8xuIYEP38zEQV/2bRyO+6eEOgO2C1uCIoMH43o8KvZ89SADrGN13X+
         fhMWNmX8GcgRNP7iFb1Yxw/DU3DtwsXkqHI4l7UtfeiYovB+DZd302ckPe5hsITr54
         kWY42rk2E625Vpr6GUOgZTZIPSD8aDORY/xOWl63g4WOgmJCuEnQr/UkFGokQCeYAD
         BDBwj+sSaJvTsKEU9S7sZIuAyeYf3ZTS04KP+jtQkZB/NM9K1OvcA8qopxBP6VZ7Rt
         P0lCbecV9bQnA==
Date:   Mon, 21 Jun 2021 10:37:58 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/556: add a check to make sure ext4 supports
 encrypted casefolding
Message-ID: <YNDOdrW0cEOhC9rZ@gmail.com>
References: <20210621164901.1809010-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621164901.1809010-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 21, 2021 at 12:49:01PM -0400, Theodore Ts'o wrote:
> diff --git a/tests/generic/556 b/tests/generic/556
> index 3145188c..7916a08e 100755
> --- a/tests/generic/556
> +++ b/tests/generic/556
> @@ -16,6 +16,7 @@ status=1 # failure is thea default
>  . ./common/attr
>  
>  _supported_fs generic
> +_require_encrypted_casefold

This isn't an encrypt+casefold test though, but rather just a casefold test.  It
only becomes an encrypt+casefold test when $MOUNT_OPTIONS includes
test_dummy_encryption.

I think we shouldn't update the test itself, but rather make
_require_scratch_casefold() call _require_encrypted_casefold() if
test_dummy_encryption is in $MOUNT_OPTIONS.

- Eric
