Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D480DC07E9B
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 17:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C009B61CD0
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 17:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhGGRg7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Jul 2021 13:36:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56819 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230266AbhGGRg7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Jul 2021 13:36:59 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 167HYBsN011696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jul 2021 13:34:12 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A8A1D15C3CC6; Wed,  7 Jul 2021 13:34:11 -0400 (EDT)
Date:   Wed, 7 Jul 2021 13:34:11 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org, shreeya.patel@collabora.com,
        djwong@kernel.org
Subject: Re: [PATCH 1/1] generic/453: Do NOT run for FSs restricting names
Message-ID: <YOXlk+CVOXWEvM7l@mit.edu>
References: <20210707102007.66774-1-preichl@redhat.com>
 <20210707102007.66774-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707102007.66774-2-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 07, 2021 at 12:20:07PM +0200, Pavel Reichl wrote:
> +_require_names_are_bytes() {
> +        case "$FSTYP" in
> +        ext2|ext3|ext4|xfs|btrfs)
> +		# do nothing
> +	        ;;
> +	*)
> +                _notrun "$FSTYP does now allow unrestricted byte streams for names"

"now" should be "not" above, I believe.

Other than that,

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
