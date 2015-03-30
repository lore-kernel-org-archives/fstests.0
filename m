Return-Path: <fstests-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60510 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbbC3No2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 30 Mar 2015 09:44:28 -0400
Date: Mon, 30 Mar 2015 15:44:10 +0200
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v9] fstests: Tests can use any name now, not 3 digits
 only.
Message-ID: <20150330134409.GG32051@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20150327072539.GB4810@dhcp-13-216.nay.redhat.com>
 <1427456966-21130-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1427456966-21130-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan =?utf-8?B?xaR1bMOhaw==?= <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 27, 2015 at 12:49:26PM +0100, Jan Ťulák wrote:
> Tests can use any name now, not 3 digits only.
> (e.g. a test can be named "tests/generic/001-some-name")
> 
> Names are limited to alphanumeric characters and dash and are always prefixed
> with an unique id for easier identification of a specific test.
> 
> Signed-off-by: Jan Ťulák <jtulak@redhat.com>

Reviewed-by: David Sterba <dsterba@suse.cz>
