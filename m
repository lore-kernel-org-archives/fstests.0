Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F23C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 19 May 2022 17:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiESRcM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 May 2022 13:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiESRcL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 May 2022 13:32:11 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFF51AD9A
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 10:32:09 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24JHVxtK007653
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 13:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652981520; bh=tZEkSA/ir7dw/ojIUTnYF9ove7Hfp1aripBb9uhZZTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=BhwNz0G7UJ1mGiNuuVMbOmolsef9LMMrzbfaPT/osT+JFFizAhsAQl/qTXpARJua2
         3mXtpFrVTG+fiflNnNjHri/9kdoy1rW1yo9fYva3PVnCWdvOeX/JT2LLjnOf27G5gX
         CjLVOrMYBXZL1HBw9jnPr3YSSo3jqcuOMqoJ35ZjWylMfw69ue7JZN8Hf/0v0SW91T
         6gwZfqeTsEjOQ+43cM3xk57Y8Q8HynuNPiliVOtSMUI0KiB0Lhb/o9bvQRCmOvs4Tn
         CYKRTsLS87CYH6HjUHzEZsP3pH4XQ7263qwkLRy1NU1hzoFF1t9T1V/FaRMzBsc8mB
         oM+9FAGw+n8ig==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 07AD415C3EC0; Thu, 19 May 2022 13:31:59 -0400 (EDT)
Date:   Thu, 19 May 2022 13:31:59 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>, zlang@redhat.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH] generic/556: Adequate expected output to touch behavior
 change
Message-ID: <YoZ/DzUTB73Cs8Ki@mit.edu>
References: <20220518202214.481121-1-krisman@collabora.com>
 <YoVl7MVtEUuupODz@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoVl7MVtEUuupODz@sol.localdomain>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 18, 2022 at 02:32:28PM -0700, Eric Biggers wrote:
> 
> This would break the test on systems that still have an older version of
> coreutils, right?  For example, currently kvm-xfstests test appliances are based
> on Debian Bullseye by default, which isn't very old, but it has coreutils 8.32.

Even Debian unstable is still using coreutils 8.32:

   https://packages.debian.org/search?keywords=coreutils&searchon=names&suite=all&section=all

> Can you filter the output to allow the test to pass with both old and new
> coreutils versions?

Gabriel, FYI, the filter functions live in common/filter.  There are a
large number of them see "git log common/filter" to see how they get
added.  For a really simple example, please see commit 90d132ee44b7:

    common/filter: add _filter_bash()
    
    This is needed to account for bash 5.1 adding line number annotation
    when executing a command via the -c option and it fails.  For example,
    "bash -c 'echo foo > /'" will cause bash 5.1 to report:
    
         bash: line 1: /: Is a directory
    
    instead of:
    
         bash: /: Is a directory

Cheers,

						- Ted
