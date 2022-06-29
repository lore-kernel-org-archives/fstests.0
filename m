Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D539C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jun 2022 19:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiF2TaQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 15:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiF2TaQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 15:30:16 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EC814035
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 12:30:14 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25TJU4Bg027684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 15:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656531006; bh=uqylQ0Whn79KJc7zMDqHohZlvy+4v6p/cycEnAwuDJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Qw2k/FUWRmyf6txKqtA9A14kIiSZY9/38k63RMGe6ZoBDaPGICo4fWa8d7rAIjwm1
         NMg5KVz/tQ+XY53vNCXXFj1LWp4MCPOVCqlMEqMpE2PHlKCF1psCKZJDjU6GUiHEcC
         k7A6GFCUmEUCOFk42OaHPuhEA8j0tBf9uxNkQN8HVivRq92qWWO3V2GVKldY4M9J1A
         mBoK2Kn9mvMY2lavyJmq9DYP6d6oh5ETNVaVrvP1L7LbAAET3cYjLKlFg/vyzxa0SN
         OerTJB0zWv9hvFePGc1QXabiE5GY8Fv0peBR1Ix4nMH4JlN5yU7FY2aR/1HxNvozJN
         A/jk+h+5qGyPw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7083915C3E94; Wed, 29 Jun 2022 15:30:04 -0400 (EDT)
Date:   Wed, 29 Jun 2022 15:30:04 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH -v3 7/7] ext4: create file systems with the encrypt
 feature as necessary
Message-ID: <YryoPGksgK3UfKvO@mit.edu>
References: <20220629124540.175775-1-tytso@mit.edu>
 <20220629124540.175775-8-tytso@mit.edu>
 <20220629133052.3knyrselanytvrws@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629133052.3knyrselanytvrws@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 29, 2022 at 09:30:52PM +0800, Zorro Lang wrote:
> 
> As Eric gave some review points to V2, so double check with Eric, if it's good
> to him?

Eric, any other issues than the ones which you had mentioned (and
which I have addressed)?

Zorro, I have the patches based against for-next, and with your
reviewed-by tags appended, and tagged with a signed tag on the
for-upstream branch up on github.  Or if you like I can resend patch
series via e-mail.

      	    	       	   	- Ted

The following changes since commit 34c1208f601b5f22c62d0f3ed6f6c55c88aa4eff:

  xfs/{422,517}: kill background jobs on test termination (2022-06-25 00:27:11 +0800)

are available in the Git repository at:

  https://github.com/tytso/xfstests tags/for-zorro

for you to fetch changes up to 43dec26fe614b1d8ad8f4c67aaf6f88413b7f2f8:

  ext4: create file systems with the encrypt feature as necessary (2022-06-29 15:11:41 -0400)

----------------------------------------------------------------
Miscellaneous ext4 test fix ups

Previous versions of this patch series can be found at:

 - v1: https://lore.kernel.org/r/20220625030718.1215980-1-tytso@mit.edu
 - v2: https://lore.kernel.org/r/20220628182545.1834145-1-tytso@mit.edu
 - v3: https://lore.kernel.org/r/20220629124540.175775-1-tytso@mit.edu

----------------------------------------------------------------
Theodore Ts'o (7):
      ext4/050: support indirect as well as extent mapped journals
      ext4/044: skip test if the file system does not have a journal
      ext4/045: _require_dumpe2fs doesn't take any arguments so remove them
      ext4/054: skip test if the dax mount option is enabled
      ext4/055: skip test if dax mount option is used
      ext4/035: skip this test if the scratch device does not support 1k block sizes
      ext4: create file systems with the encrypt feature as necessary

 common/rc         |  3 +++
 tests/ext4/003    |  6 +++++-
 tests/ext4/035    |  8 +++++++-
 tests/ext4/044    |  1 +
 tests/ext4/045    |  2 +-
 tests/ext4/050    | 58 +++++-----------------------------------------------------
 tests/ext4/054    |  5 ++---
 tests/ext4/055    |  1 +
 tests/ext4/306    |  3 +++
 tests/generic/260 |  5 ++++-
 10 files changed, 32 insertions(+), 60 deletions(-)
